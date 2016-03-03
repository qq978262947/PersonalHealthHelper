//
//  PHMoreRightView.m
//  百思不得姐
//
//  Created by 汪俊 on 16/2/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "PHMoreRightView.h"
#import "PHRightTableViewCell.h"
#import "MJRefreshBackNormalFooter.h"
#import "Masonry.h"

@interface PHMoreRightView () <UITableViewDelegate , UITableViewDataSource>


@end

@implementation PHMoreRightView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupTableView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupTableView];
    }
    return self;
}
/**
 *  初始化tableview
 */
- (void)setupTableView{
    //设置tableview
    self.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc]init];
    [self addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    //设置tableview背景色
    UIView *bgView = [[UIView alloc]initWithFrame:tableView.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    [tableView setBackgroundView:bgView];

    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake( 64, 0, 44, 0);
}


//布局当前视图
- (void)layoutTableView{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self);
        make.center.equalTo(self);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutTableView];
}



#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PHRightTableViewCell *cell = [PHRightTableViewCell rightCellWithTableView:tableView];
    cell.user = self.users[indexPath.row];
    return cell;
}

#pragma mark - <tableviewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

- (NSMutableArray *)users{
    if (nil == _users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
