//
//  PHMsgTableController.m
//  PersonalHealthHelper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 PH. All rights reserved.
//

#import "PHMsgTableController.h"

@interface PHMsgTableController ()

@end

@implementation PHMsgTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
}
-(void)downloadClassMsg
{
    NSString * currentDate=[NSDate currentDateStringWithFormat:@"yyyyMM ddHHmmss"];
    NSString * usefulDate=[currentDate stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString * path=@"96-109";
    NSString * sign=[NSString stringWithFormat:@"showapi_appid%@showapi_timestamp%@tid1%@",PHID,usefulDate,PHSerect];
    
    NSString * md5Sign=[sign md532BitLower];
    NSDictionary * param =@{
                            @"tid":@1,
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
                 NSLog(@"%@",dict);
                 //进行json解析
                 NSDictionary * temp1=dict[@"showapi_res_body"];
                 NSDictionary * temp2=dict[@"pagebean"];
             }
         }
         else
         {
             NSLog(@"%@",result);
             NSLog(@"请求失败");
         }
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
