//
//  PHCheckHomeView.h
//  PersonalHealthHelper
//
//  Created by 汪俊 on 16/3/1.
//  Copyright © 2016年 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHCheckHomeView;

@protocol PHCheckHomeViewDelegate <NSObject>

- (void)homeView:(PHCheckHomeView *)homeView didClickSearchButton:(UIButton *)searchButton;

- (void)homeView:(PHCheckHomeView *)homeView didClickShowAllButton:(UIButton *)showAllButton;

@end



@interface PHCheckHomeView : UIView

@property (weak, nonatomic)id<PHCheckHomeViewDelegate> delegate;

@property (weak, nonatomic) UITextField *textField;

@property (weak, nonatomic) UIButton *btn;

+ (instancetype)homeView;

- (void)showEnd;

- (void)showText:(NSString *)text;

@end
