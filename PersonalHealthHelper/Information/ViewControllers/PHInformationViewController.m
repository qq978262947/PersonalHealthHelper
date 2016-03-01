//
//  PHInformationViewController.m
//  PersonalHealthHelper
//
//  Created by lifan on 16/3/1.
//  Copyright © 2016年 PH. All rights reserved.
//

#import "PHInformationViewController.h"
#import "PersonalHealthHelper-Swift.h"

#import "NSDate+Formatter.h"
#import "NSString+MD5.h"

#import "TSScrollBtn.h"

#import "PHHMModel.h"
@interface PHInformationViewController ()
@property (nonatomic,strong)NSMutableArray * listArray;
@property (nonatomic,strong)UIView * scrollBtn;
@end

@implementation PHInformationViewController

-(NSMutableArray *)listArray
{
    if (_listArray==nil)
    {
        _listArray=[NSMutableArray array];
    }
    return _listArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"资讯";
    [self downLoadData];
    self.view.backgroundColor=[UIColor whiteColor];
}

//获取主界面数据
-(void)downLoadData
{
    NSString * currentDate=[NSDate currentDateStringWithFormat:@"yyyyMM ddHHmmss"];
    NSString * usefulDate=[currentDate stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString * path=@"96-108";
    NSString * sign=[NSString stringWithFormat:@"showapi_appid%@showapi_timestamp%@%@",PHID,usefulDate,PHSerect];
    
    NSString * md5Sign=[sign md532BitLower];
    NSDictionary * param =@{
                            @"showapi_appid":PHID,
                            @"showapi_timestamp":usefulDate,
                            @"showapi_sign":md5Sign
                            };
    
    [PHNetHelper postWithParam:param andPath:path andComplete:^(BOOL success, id result) {
        
        if (success)
        {
            NSLog(@"请求成功");
            NSError * error;
            NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:&error];
            if (error)
            {
                
                NSLog(@"解析失败%@",error);
            }
            else
            {
                NSDictionary * body=dict[@"showapi_res_body"];
                NSArray * list= body[@"list"];
                for (NSDictionary * tempDict in list)
                {
                    PHHMModel * mod= [PHHMModel modWithDict:tempDict];
                    [self.listArray addObject:mod];
                }
                NSLog(@"%@",self.listArray);
                //获取数据成功，分页展示
                [self createScrollBtn];
            }
        }
        else
        {
            NSLog(@"%@",result);
            NSLog(@"请求失败");
        }
    }];
}
-(void)createScrollBtn
{
    NSMutableArray * names=[NSMutableArray array];
    for (int i = 0; i<self.listArray.count; i++)
    {
        NSString * name= self.listArray[i];
        [names addObject:name];
    }
    TSScrollBtn * scrollBtn=[TSScrollBtn new];
    self.scrollBtn=scrollBtn;
    scrollBtn.nameArray=names;
    [self.view addSubview:scrollBtn];
    [scrollBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.centerX.equalTo(0);
        make.height.equalTo(50);
    }];
}
//获取具体每一条数据
-(void)downLoadRowsMsgWithModel
{
    /**
     https://route.showapi.com/
     96-36?
     id=045445&
     showapi_appid=16297&
     showapi_timestamp=20160301142552&
     showapi_sign=aaefa35d168ce4c6c5143d1ac4ba9784
     */
    
    NSString * currentDate=[NSDate currentDateStringWithFormat:@"yyyyMM ddHHmmss"];
    NSString * usefulDate=[currentDate stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString * path=@"96-108";
    //这里通过model获取id,并且加入序列中
    NSString * sign=[NSString stringWithFormat:@"showapi_appid%@showapi_timestamp%@%@",PHID,usefulDate,PHSerect];
    
    NSString * md5Sign=[sign md532BitLower];
    NSDictionary * param =@{
                            @"showapi_appid":PHID,
                            @"showapi_timestamp":usefulDate,
                            @"showapi_sign":md5Sign
                            };
    
    [PHNetHelper postWithParam:param andPath:path andComplete:^(BOOL success, id result) {
        
        if (success)
        {
            NSLog(@"请求成功");
            NSError * error;
            NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:&error];
            if (error)
            {
                NSLog(@"解析失败%@",error);
            }
            else
            {
                //获取名称
                
                
                NSLog(@"%@",dict);
            }
        }
        else
        {
            NSLog(@"%@",result);
            NSLog(@"请求失败");
        }
    }];
    
}
-(void)searchBtnTouch
{
    /**
     *  https://route.showapi.com/
     96-109?
     keyword=&
     page=&
     showapi_appid=16297&
     showapi_timestamp=20160301142507&
     tid=&
     showapi_sign=41b2bffeb985997cd485d8db08836fd9
     
     */
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
