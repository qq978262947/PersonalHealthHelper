//
//  PHShowController.m
//  PersonalHealthHelper
//
//  Created by 汪俊 on 16/3/2.
//  Copyright © 2016年 PH. All rights reserved.
//

#import "PHShowController.h"
#import "NSDate+Formatter.h"
#import "AFNetworking.h"
#import "NSString+MD5.h"
#import "PHMoreLeftView.h"
#import "PHMoreRightView.h"
#import "PHCheckList.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"

#define PHScreenW [UIScreen mainScreen].bounds.size.width
#define PHScreenH [UIScreen mainScreen].bounds.size.height


#define secret @"b034a3a7f7b144debe727ccebff2fd23"

@interface PHShowController () <PHMoreLeftViewDelegate>

@property (weak, nonatomic) PHMoreLeftView *leftView;
@property (weak, nonatomic) PHMoreRightView *rightView;

@property (strong, nonatomic)NSArray *listArray;
@end

@implementation PHShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    PHMoreLeftView *leftView = [[PHMoreLeftView alloc]init];
    
    self.leftView = leftView;
    
    leftView.delegate = self;
    
    leftView.frame = CGRectMake(0, 0, 100, PHScreenH);
    
    [self.view addSubview:leftView];
    
    PHMoreRightView *rightView = [[PHMoreRightView alloc]init];
    
    rightView.frame = CGRectMake(100, 0, PHScreenW - 100, PHScreenH);
    
    self.rightView = rightView;
    
    [self.view addSubview:rightView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadData];
}

- (void)loadData {
    NSString *dataString = [NSDate currentDateStringWithFormat:@"yyyyMMdd HHmmss"];
    dataString = [dataString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *sign = [NSString stringWithFormat:@"showapi_appid%@showapi_timestamp%@%@",@"16299",dataString,secret];
    sign = [sign md532BitLower];
    NSDictionary *param = @{
                            @"showapi_appid" : @"16299",
                            @"showapi_sign" : sign,
                            @"showapi_timestamp": dataString,
                            };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
#warning －请求－
    [manager POST:@"http://route.showapi.com/546-1" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject[@"showapi_res_body"];
        if ([dict[@"ret_code"]integerValue] == 0) {
             ;
            
            self.listArray = [PHCheckList mj_objectArrayWithKeyValuesArray:dict[@"list"]];
            self.leftView.categories = self.listArray;
            // 默认选中首行
            [self.leftView.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
            [self friendsLeftView:self.leftView didClickIndex:0];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载分类信息失败!"];
    }];
}

- (void)friendsLeftView:(PHMoreLeftView *)leftView didClickIndex:(NSInteger)index {
    PHCheckList *description = self.listArray[index];
    [self.rightView.users removeAllObjects];
    [self.rightView.users addObjectsFromArray:description.subList];
    [self.rightView.tableView reloadData];
}

@end
