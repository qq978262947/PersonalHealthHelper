//
//  PHShowAllController.m
//  PersonalHealthHelper
//
//  Created by 汪俊 on 16/3/2.
//  Copyright © 2016年 PH. All rights reserved.
//

#import "PHShowAllController.h"
#import "AFNetworking.h"
#import "NSDate+Formatter.h"
#import "NSString+MD5.h"
#import "PHSickList.h"
#import "SVProgressHUD.h"

#define secret @"b034a3a7f7b144debe727ccebff2fd23"

@interface PHShowAllController ()
@property (weak, nonatomic) IBOutlet UIButton *goprevoius;

@property (weak, nonatomic) IBOutlet UIButton *goNext;
@property (weak, nonatomic) IBOutlet UITextView *contentText;

@property (assign, nonatomic)int page;
@end

@implementation PHShowAllController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentText.editable = NO;
    self.page = 0;
    
    [self loadData];
    
}
- (IBAction)goPreious:(id)sender {
    self.page--;
    [self loadData];
}
- (IBAction)goToNext:(id)sender {
    self.page ++;
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {

    self.goNext.enabled = !(self.listArray.count == self.page + 1);
    self.goprevoius.enabled = !(0 == self.page);
    
    PHSickList *sickList = self.listArray[self.page];
    NSString *ID = sickList.ID;
    self.title = sickList.name;
    
    NSString *dataString = [NSDate currentDateStringWithFormat:@"yyyyMMdd HHmmss"];
    dataString = [dataString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *sign = [NSString stringWithFormat:@"id%@showapi_appid%@showapi_timestamp%@%@", ID,@"16299",dataString,secret];
    sign = [sign md532BitLower];
    NSDictionary *param = @{
                            @"showapi_appid" : @"16299",
                            @"showapi_sign" : sign,
                            @"showapi_timestamp": dataString,
                            @"id" : ID
                            };
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    
#warning －请求－
    [manager GET:@"http://route.showapi.com/546-3" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject[@"showapi_res_body"];
        NSDictionary *item = dict[@"item"];
        NSString *content = [NSString stringWithFormat:@"%@\n\n",item[@"summary"]];
        if ([dict[@"ret_code"]integerValue] == 0) {
             NSArray *array = item[@"tagList"];
            for (int i = 0; i < array.count; i ++) {
                NSDictionary *listDict = array[i];
                content = [NSString stringWithFormat:@"%@\n",listDict[@"content"]];
                content = [content stringByReplacingOccurrencesOfString:@"</p><p>" withString:@"\n"];
                content = [content stringByReplacingOccurrencesOfString:@"<p>" withString:@"\n"];
                content = [content stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            }
             self.contentText.text = content;
        }
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

@end
