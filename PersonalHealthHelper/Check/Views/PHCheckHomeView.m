//
//  PHCheckHomeView.m
//  PersonalHealthHelper
//
//  Created by 汪俊 on 16/3/1.
//  Copyright © 2016年 PH. All rights reserved.
//

#import "PHCheckHomeView.h"
#import "Masonry.h"

#define PHBtnNormalTitle @"健康诊断"
#define PHBtnHeightTitle @"停止诊断"
#define PHRectHeight 200

@interface PHCheckHomeView ()
@property (weak, nonatomic) UIView *rectView;
@property (weak, nonatomic) UILabel *label;
/**
 *  按钮
 */
@property (weak, nonatomic) UIButton *moreButton;
/**
 *  分割线
 */
@property (weak, nonatomic) UIView *speratorView;
@property (strong, nonatomic) NSTimer *timer;
/**
 *  计时
 */
@property (assign, nonatomic) NSTimeInterval timeInterval;;
@end

@implementation PHCheckHomeView
+ (instancetype)homeView{
    return [[self alloc]initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //1 添加label
        UILabel *label = [[UILabel alloc]init];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        NSString *string =  @"搜寻疾病,健康出行！！！\n身体倍好\n健健康康出行！～\n哦，耶～～～～";
        label.text = string;
        self.label = label;
        [self addSubview:label];
        [self constraintLabel];
        
        //2 添加rectview
        UIView *rectView = [[UIView alloc]init];
        self.rectView = rectView;
        [self addSubview:rectView];
        rectView.backgroundColor = [UIColor colorWithRed:0.1962 green:1.0 blue:0.1257 alpha:0.127074353448276];
        [self constraintRectView];
        //3 添加扫描线
        UIView *speratorView = [[UIView alloc]init];
        [rectView addSubview:speratorView];
        self.speratorView = speratorView;
        [self constraintSperatorView];
        speratorView.backgroundColor = [UIColor greenColor];
        
        //4 添加button
        UIButton *moreButton = [[UIButton alloc]init];
        self.moreButton = moreButton;
        [self addSubview:moreButton];
        [moreButton setTitle:@"健康诊断" forState:UIControlStateNormal];
        [moreButton addTarget:self action:@selector(checkHealthy) forControlEvents:UIControlEventTouchUpInside];
        [self constraintMoreButton];
        moreButton.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)constraintMoreButton {
    __weak typeof(self)weakSelf = self;
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.label.mas_bottom).offset(5);
        make.centerX.equalTo(weakSelf);
        make.height.equalTo(@40);
        make.width.equalTo(@200);
    }];
}

- (void)checkHealthy {
    if ((self.moreButton.selected = !self.moreButton.selected)) {
        [self.moreButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        self.moreButton.backgroundColor = [UIColor colorWithRed:0.2496 green:1.0 blue:0.174 alpha:0.357866379310345];
        [self.moreButton setTitle:PHBtnHeightTitle forState:UIControlStateNormal];
        [self startCheck];
    } else {
        [self.moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.moreButton.backgroundColor = [UIColor greenColor];
        [self.moreButton setTitle:PHBtnNormalTitle forState:UIControlStateNormal];
        [self endCheck];
    }
}
/**
 *  开启扫描
 */
- (void)startCheck {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(healthCheck) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    self.timeInterval = 0;
}

/**
 *  结束扫描
 */
- (void)endCheck {
    [self.timer invalidate];
    self.timeInterval = 0;
}

- (void)healthCheck {
    if (self.timeInterval > 4) {
        [self endCheck];
    }
    self.timeInterval++;
    [UIView animateWithDuration:0.75 animations:^{
        [self updateSperatorViewConstraintsWithY:0];
    } completion:^(BOOL finished) {
        [self updateSperatorViewConstraintsWithY:PHRectHeight];
    }];
}

/**
 *   更新约束
 */
- (void)updateSperatorViewConstraintsWithY:(CGFloat)y{
    __weak typeof(self) weakSelf = self;
    //添加动画
    [self.speratorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.rectView);
        make.height.equalTo(@1);
        make.bottom.equalTo(weakSelf.rectView.mas_top).offset(y);
        make.centerX.equalTo(weakSelf.rectView);
    }];
    //必须调用此方法，才能出动画效果
    [self layoutIfNeeded];
}

/**
 *  约束imageview
 */
- (void)constraintRectView {
    __weak typeof(self)weakSelf = self;
    [self.rectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.label.mas_top).offset(-2);
        make.width.height.equalTo(@(PHRectHeight));
        make.centerX.equalTo(weakSelf);
    }];
}

- (void)constraintLabel {
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@290);
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@120);
    }];
}

- (void)constraintSperatorView {
    __weak typeof(self)weakSelf = self;
    [self.speratorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.rectView);
        make.height.equalTo(@1);
        make.bottom.equalTo(weakSelf.rectView.mas_top);
        make.centerX.equalTo(weakSelf.rectView);
    }];
}

@end
