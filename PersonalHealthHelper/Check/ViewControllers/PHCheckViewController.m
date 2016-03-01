//
//  PHCheckViewController.m
//  PersonalHealthHelper
//
//  Created by lifan on 16/3/1.
//  Copyright © 2016年 PH. All rights reserved.
//

#import "PHCheckViewController.h"
#import "PHCheckHomeView.h"
#import "PersonalHealthHelper-Swift.h"

@interface PHCheckViewController ()

@end

@implementation PHCheckViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    PHCheckHomeView *homeView = [PHCheckHomeView homeView];
    
    [self.view addSubview:homeView];
}

#pragma mark - UITableViewDelegate



#pragma mark - Custom Delegate



#pragma mark - Event Response



#pragma mark - Private Methods



#pragma mark - Setter & Getter



@end
