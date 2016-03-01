//
//  PHInformationViewController.m
//  PersonalHealthHelper
//
//  Created by lifan on 16/3/1.
//  Copyright © 2016年 PH. All rights reserved.
//

#import "PHInformationViewController.h"
#import "PersonalHealthHelper-Swift.h"
#import "PHMsgTableView.h"

#import "NSDate+Formatter.h"
#import "NSString+MD5.h"

#import "PHBtnsBar.h"

#import "PHHMModel.h"
@interface PHInformationViewController ()<PHBtnsBarDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray * listArray;
@property (nonatomic,strong)PHBtnsBar * scrollBtn;

@property (nonatomic,strong)UIScrollView * scrollView;
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
    self.automaticallyAdjustsScrollViewInsets=NO;
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
    [PHNetHelper postWithParam:param andPath:path andComplete:^(BOOL success, id result)
    {
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
//创建顶部导航工具条
-(void)createScrollBtn
{
    NSMutableArray * names=[NSMutableArray array];
    for (int i = 0; i<self.listArray.count; i++)
    {
        PHHMModel * mod= self.listArray[i];
        NSString * name= mod.name;
        [names addObject:name];
    }
    PHBtnsBar * btnsbar=[PHBtnsBar btnsBarWithFrame:CGRectMake(0, NAVH+20,SCRW , BTNH) andNameArray:names];
    [self.view addSubview:btnsbar];
    self.scrollBtn=btnsbar;
    btnsbar.delegate=self;
    [self configTableVeiws];
}
-(void)configTableVeiws
{
    UIScrollView * scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVH+BTNH+20, SCRW, SCRH-NAVH-BTNH-20-TabbarH)];
    [self.view addSubview:scrollView];
    self.scrollView=scrollView;
    scrollView.autoresizesSubviews=NO;
    scrollView.backgroundColor=[UIColor greenColor];
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    
    scrollView.contentSize=CGSizeMake(scrollView.frame.size.width*self.listArray.count, scrollView.frame.size.height);
    for (int i = 0; i < self.listArray.count;i++)
    {
        PHHMModel * mod= self.listArray[i];
        NSNumber * tid=mod.ID;
        CGRect frame= CGRectMake(i*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        
        PHMsgTableView * table=[PHMsgTableView phmsgTableViewWithFrame:frame andtid:tid];
        [self.scrollView addSubview:table];
        NSLog(@"%@",NSStringFromCGRect(table.frame));
    }
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
    
    NSString * path=@"96-109";
    //这里通过model获取id,并且加入序列中
    NSString * sign=[NSString stringWithFormat:@"showapi_appid%@showapi_timestamp%@%@tid1",PHID,usefulDate,PHSerect];
    
    NSString * md5Sign=[sign md532BitLower];
    NSDictionary * param =@{
                            @"tid":@1,
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
#pragma mark ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.scrollBtn.selectNumber=(scrollView.contentOffset.x+150)/scrollView.frame.size.width;
}
#pragma  mark PHBtnsBarDelegate
-(void)phBtnBar:(PHBtnsBar *)bar btnTouchWihtTag:(NSInteger)tag
{
    //通过代理实现跳转
    CGPoint point = CGPointMake(tag*self.scrollView.frame.size.width, 0);
    self.scrollView.contentOffset=point;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
