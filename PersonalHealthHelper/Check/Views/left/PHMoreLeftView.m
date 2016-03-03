//
//  PHMoreLeftView.m
//  百思不得姐
//
//  Created by 汪俊 on 16/2/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "PHMoreLeftView.h"
#import "PHMoreLeftViewCell.h"
#import "Masonry.h"

@interface PHMoreLeftView () <UITableViewDelegate , UITableViewDataSource>



@end

@implementation PHMoreLeftView

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
    //设置背景色和frame
    self.backgroundColor = [UIColor yellowColor];
    UITableView *tableView = [[UITableView alloc]init];
    [self addSubview:tableView];
    self.tableView = tableView;
    //设置代理和数据源
    tableView.delegate = self;
    tableView.dataSource = self;
    //取消竖直滚动条
    tableView.showsVerticalScrollIndicator = NO;
    //设置背景颜色
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
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PHMoreLeftViewCell *cell = [PHMoreLeftViewCell leftCellWithTableView:tableView];
    cell.category = self.categories[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(friendsLeftView:didClickIndex:)]) {
        [self.delegate friendsLeftView:self didClickIndex:indexPath.row];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


- (void)setCategories:(NSArray *)categories{
    _categories = categories;
    [self.tableView reloadData];
}


@end
