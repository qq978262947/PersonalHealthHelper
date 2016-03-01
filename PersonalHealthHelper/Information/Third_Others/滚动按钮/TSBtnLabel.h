//
//  TSBtnLabel.h
//  新浪新闻联系
//
//  Created by qianfeng on 15/12/24.
//  Copyright (c) 2015年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSBtnLabel;//传入按钮名称数组，通过代理传出点击的按钮
@protocol TSBtnLabelDelegate <NSObject>

-(void)TSBtnLabelBtnTouch:(UIButton *)button;

@end


@interface TSBtnLabel : UIView
@property (nonatomic,copy)NSMutableArray * btnArray;
@property (nonatomic,strong)NSArray * nameArray;
@property (nonatomic,strong)id<TSBtnLabelDelegate>delegate;
@property (nonatomic,strong)UIView * backView;
@property (nonatomic,assign)NSInteger pageNow;
@end
