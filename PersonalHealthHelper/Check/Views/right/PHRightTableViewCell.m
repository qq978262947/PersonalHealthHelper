//
//  PHFriendsRightView.m
//  百思不得姐
//
//  Created by 汪俊 on 16/2/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "PHRightTableViewCell.h"
//#import <UIImageView+WebCache.h>

@interface PHRightTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *fancs;

@end

@implementation PHRightTableViewCell
- (IBAction)clickAddFriend:(id)sender {
}
/**
 *  得到tableview
 *
 *  @param tableView cell所属的tableView
 *
 *  @return 指定tableview的cell
 */
+ (PHRightTableViewCell *)rightCellWithTableView:(UITableView *)tableView{
    NSString * className = NSStringFromClass([self class]);
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupTableViewCell];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupTableViewCell];
    }
    return self;
}

/**
 *  初始化cell
 */
- (void)setupTableViewCell{
    //设置cell的背景色
    self.backgroundColor = [UIColor whiteColor];
}

/**
 * 可以在这个方法中监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setUser:(PHDescription *)user{
    _user = user;
    
    self.name.text = user.subName;
    self.fancs.text = [NSString stringWithFormat:@"%li", [user.subId integerValue]];
}


@end
