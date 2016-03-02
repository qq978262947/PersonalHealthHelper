//
//  PHMsgTableController.m
//  PersonalHealthHelper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 PH. All rights reserved.
//

#import "PHMsgTableView.h"
#import "PHMsgTableMod.h"
#import "PHMsgCell.h"

@interface PHMsgTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation PHMsgTableView
-(UITableView *)tableView
{
    if (_tableView==nil)
    {
        _tableView=[[UITableView alloc]initWithFrame:self.bounds];
        [self addSubview:_tableView];
        _tableView.dataSource=self;
        _tableView.delegate=self;
    }
    return _tableView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
    }
    return self;
}
-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(void)setTid:(NSNumber *)tid
{
    _tid=tid;
    [self downloadClassMsgWithtid:tid];
}
+(instancetype)phmsgTableViewWithFrame:(CGRect)frame andtid:(NSNumber *)tid
{
    PHMsgTableView * table=[[PHMsgTableView alloc]initWithFrame:frame];
    table.tid=tid;
    return table;
}

-(void)downloadClassMsgWithtid:(NSNumber *)pid
{
    NSString * currentDate=[NSDate currentDateStringWithFormat:@"yyyyMM ddHHmmss"];
    NSString * usefulDate=[currentDate stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString * path=@"96-109";
    NSString * sign=[NSString stringWithFormat:@"showapi_appid%@showapi_timestamp%@tid%@%@",PHID,usefulDate,self.tid,PHSerect];
    
    NSString * md5Sign=[sign md532BitLower];
    NSDictionary * param =@{
                            @"tid":self.tid,
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
                 //进行json解析
                 NSDictionary * temp1=dict[@"showapi_res_body"];
                 NSDictionary * temp2=temp1[@"pagebean"];
                 NSArray * contentList=temp2[@"contentlist"];
                 for (NSDictionary * dict in contentList)
                 {
                     PHMsgTableMod * mod= [PHMsgTableMod modWithDict:dict];
                     [self.dataArray addObject:mod];
                 }
                 //刷新
                 [self.tableView reloadData];
             }
         }
         else
         {
             NSLog(@"%@",result);
             NSLog(@"请求失败");
         }
     }];
}
#pragma mark - Table view data source
//条目
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PHMsgCell * cell=[PHMsgCell cellWithTableView:tableView];
    [cell configCellWithMod:self.dataArray[indexPath.row]];
    NSLog(@"1");
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

@end
