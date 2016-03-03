//
//  PHFriendsRightView.h
//  百思不得姐
//
//  Created by 汪俊 on 16/2/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHDescription.h"

@interface PHRightTableViewCell : UITableViewCell
+ (PHRightTableViewCell *)rightCellWithTableView:(UITableView *)tableView;

@property (strong,nonatomic)PHDescription *user;

@end
