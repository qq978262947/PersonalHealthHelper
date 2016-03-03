//
//  PHMoreRightView.h
//  百思不得姐
//
//  Created by 汪俊 on 16/2/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHMoreRightView : UIView


/** 右边的用户数据 */
@property (strong ,nonatomic) NSMutableArray *users;

/**
 *  显示数据的tableview
 */
@property (weak ,nonatomic)UITableView *tableView;


@end
