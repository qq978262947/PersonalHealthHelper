//
//  PHCheckViewController.m
//  PersonalHealthHelper
//
//  Created by lifan on 16/3/1.
//  Copyright © 2016年 PH. All rights reserved.
//

#import "PHCheckViewController.h"
#import "PHCheckHomeView.h"
#import "Masonry.h"
#import "PersonalHealthHelper-Swift.h"

@interface PHCheckViewController ()
@property (weak, nonatomic) PHCheckHomeView *homeView;
@end

@implementation PHCheckViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    PHCheckHomeView *homeView = [PHCheckHomeView homeView];
    
    self.homeView = homeView;
    
    [self.view addSubview:homeView];
    
    [self constraintHomeView];
}

#pragma mark - UITableViewDelegate



#pragma mark - Custom Delegate



#pragma mark - Event Response



#pragma mark - Private Methods
- (void)constraintHomeView {
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(@0);
    }];
    
}


#pragma mark - Setter & Getter



@end
