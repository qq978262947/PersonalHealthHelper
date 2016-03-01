//
//  TSScrollBtn.h
//  TSScrollBtn
//
//  Created by qianfeng on 15/12/23.
//  Copyright (c) 2015年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSScrollBtn;//传入按钮名称，通过代理传出选择视图与按钮号
@protocol TSScrollBtnDelegate <NSObject>

-(void)TSScrollBtnTouchWithIndex:(NSInteger)index;
-(void)TSScrollBtnMenuTouchGetView:(UIView *)menuView;

@end
@interface TSScrollBtn : UIView
//这个数组传入按钮
@property (nonatomic,strong)NSMutableArray * btnArray;
@property (nonatomic,strong)NSArray * nameArray;
@property (nonatomic,strong)id<TSScrollBtnDelegate> delegate;
@property (nonatomic,strong)UIButton * menuBtn;
@property (nonatomic,assign)NSInteger pageNow;
@end
