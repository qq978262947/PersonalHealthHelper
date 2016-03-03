//
//  PHCheckViewController.m
//  PersonalHealthHelper
//
//  Created by lifan on 16/3/1.
//  Copyright © 2016年 PH. All rights reserved.
//

#import "PHCheckViewController.h"
#import "PHCheckHomeView.h"
#import "Masonry.h"
#import "PersonalHealthHelper-Swift.h"
#import "AFNetworking.h"
#import "NSDate+Formatter.h"
#import "NSString+MD5.h"
#import "PHShowController.h"
#import "MJExtension.h"
#import "PHSickList.h"
#import "PHShowAllController.h"

#define secret @"b034a3a7f7b144debe727ccebff2fd23"
#define PHScreenW [UIScreen mainScreen].bounds.size.width
#define PHScreenH [UIScreen mainScreen].bounds.size.height

@interface PHCheckViewController () <PHCheckHomeViewDelegate>
@property (weak, nonatomic) PHCheckHomeView *homeView;


@property (strong, nonatomic) NSArray *sickList;
@end

@implementation PHCheckViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    PHCheckHomeView *homeView = [PHCheckHomeView homeView];
    
    self.homeView = homeView;
    
    homeView.delegate = self;
    
    [self.view addSubview:homeView];
    
    [self constraintHomeView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分类" style:UIBarButtonItemStylePlain target:self action:@selector(goMore)];
    
    self.navigationController.hidesBottomBarWhenPushed = YES;
}

#pragma mark - UITableViewDelegate



#pragma mark - Custom Delegate
- (void)homeView:(PHCheckHomeView *)homeView didClickSearchButton:(UIButton *)searchButton {
    [self.homeView showText:@""];
    NSString *text = self.homeView.textField.text;
    if ([self isEqualSpace:text]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.homeView showEnd];
            [self.homeView showText:@"请输入搜索内容🔍"];
        });
        return;
    }
    NSString *dataString = [NSDate currentDateStringWithFormat:@"yyyyMMdd HHmmss"];
    dataString = [dataString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *sign = [NSString stringWithFormat:@"key%@showapi_appid%@showapi_timestamp%@%@",text ,@"16299",dataString,secret];
    sign = [sign md532BitLower];
    NSDictionary *param = @{
                            @"showapi_appid" : @"16299",
                            @"showapi_sign" : sign,
                            @"showapi_timestamp": dataString,
                            @"key" : text
                            };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
  
#warning －请求－
    [manager GET:@"http://route.showapi.com/546-2" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject[@"showapi_res_body"];
        NSDictionary *pageBean = dict[@"pagebean"];
        if ([dict[@"ret_code"]integerValue] == 0) {
            NSArray *sickList = [PHSickList mj_objectArrayWithKeyValuesArray:pageBean[@"contentlist"]];
            if (sickList != nil && sickList.count > 0) {
                [self showSickList:sickList];
            }else {
                [self.homeView showEnd];
                [self.homeView showText:@"非常抱歉,没有相关信息哦～～～～～"];
            }
            
            self.sickList = sickList;
        }else {
            [self.homeView showText:@"抱歉,未找到"];
        }
            
         
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.homeView showText:@"抱歉,未找到相关信息"];
         [self.homeView showEnd];
    }];
}



- (void)homeView:(PHCheckHomeView *)homeView didClickShowAllButton:(UIButton *)showAllButton {
//    NSString *dataString = [NSDate currentDateStringWithFormat:@"yyyyMMdd HHmmss"];
//    dataString = [dataString stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSString *sign = [NSString stringWithFormat:@"showapi_appid%@showapi_timestamp%@%@" ,@"16299",dataString,secret];
//    sign = [sign md532BitLower];
//    NSDictionary *param = @{
//                            @"showapi_appid" : @"16299",
//                            @"showapi_sign" : sign,
//                            @"showapi_timestamp": dataString,
//                            };
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
//    
//#warning －请求－
//    [manager GET:@"http://route.showapi.com/546-3" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dict = responseObject[@"showapi_res_body"];
//        NSDictionary *pageBean = dict[@"pagebean"];
//        if ([dict[@"ret_code"]integerValue] == 0) {
//            NSArray *sickList = [PHSickList mj_objectArrayWithKeyValuesArray:pageBean[@"contentlist"]];
//            [self showSickList:sickList];
//        }else {
//            [self.homeView showText:@"抱歉,未找到"];
//        }
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self.homeView showText:@"抱歉,未找到相关信息"];
//        [self.homeView showEnd];
//    }];
    if (self.sickList == nil || self.sickList.count == 0) return;
    PHSickList *sickList = self.sickList[0];
    if (!sickList.ID) return;
    PHShowAllController *showAllController = [[PHShowAllController alloc]init];
    showAllController.listArray = self.sickList;
    [self.navigationController pushViewController:showAllController animated:YES];
}

#pragma mark - Event Response



#pragma mark - Private Methods
- (void)constraintHomeView {
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(@0);
    }];
    
}


- (BOOL)isEqualSpace:(NSString *)str {
    if ([str isEqualToString:@""]) return YES;
    for (int i = 0 ; i < str.length - 1; i++) {
        if ([str characterAtIndex:i] != ' ') return NO;
    }
    return YES;
}

- (void)showSickList:(NSArray *)sickList {
    [self.homeView showEnd];
    if (sickList == nil || sickList.count == 0){
        [self.homeView showText:@"请检查搜索的关键字🔍"];
        return;
    }
    NSMutableString *sickString = [NSMutableString string];
    for (id sicks in sickList) {
        PHSickList *sickList = (PHSickList *)sicks;
        if (sickList.summary == nil) {
            [self.homeView showText:@"搜索关键字有误🔍"];
            return;
        }
        [sickString appendFormat:@"%@\n", sickList.summary];
    }
    NSString *sickFinalString = [sickString stringByReplacingOccurrencesOfString:@"</p><p>" withString:@"\n"];
    sickFinalString = [sickFinalString stringByReplacingOccurrencesOfString:@"<p>" withString:@"\n"];
    sickFinalString = [sickFinalString stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    [self.homeView showText:sickFinalString];
    [self.homeView showText:sickString];
}

- (void)goMore {
    PHShowController *showController = [[PHShowController alloc]init];
    [self.navigationController pushViewController:showController animated:YES];
}

#pragma mark - Setter & Getter



@end
