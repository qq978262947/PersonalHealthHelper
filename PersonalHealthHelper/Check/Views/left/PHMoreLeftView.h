//
//  PHMoreLeftView.h
//  百思不得姐
//
//  Created by 汪俊 on 16/2/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHMoreLeftView;

@protocol PHMoreLeftViewDelegate <NSObject>
/**
 *  点击了左侧的哪一行
 *
 *  @param leftView 左边的view
 *  @param index    tableview的行数
 */
- (void)friendsLeftView:(PHMoreLeftView *)leftView didClickIndex:(NSInteger)index;

@end

@interface PHMoreLeftView : UIView

/** 左边的类别数据 */
@property (strong ,nonatomic) NSArray *categories;
/**PHMoreLeftView的代理*/
@property (weak ,nonatomic)id<PHMoreLeftViewDelegate> delegate;
/** 显示数据的tableview*/
@property (nonatomic,weak)UITableView *tableView;

@end
