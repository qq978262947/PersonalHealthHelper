//
//  PHMoreLeftViewCell.m
//  百思不得姐
//
//  Created by 汪俊 on 16/2/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "PHMoreLeftViewCell.h"
#import "PHCheckList.h"

@interface PHMoreLeftViewCell ()
/** 选中时显示的指示器控件 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;
/** 类别模型 */
@property (weak, nonatomic) IBOutlet UILabel *categoryTextLabel;

@end

@implementation PHMoreLeftViewCell

/**
 *  得到tableview
 *
 *  @param tableView cell所属的tableView
 *
 *  @return 指定tableview的cell
 */
+ (PHMoreLeftViewCell *)leftCellWithTableView:(UITableView *)tableView{
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

- (instancetype)init {
    if (self = [super init]) {
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
    //设置指示器的颜色
    self.selectedIndicator.backgroundColor = [UIColor greenColor];
    
}

/**
 * 可以在这个方法中监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    self.selectedIndicator.hidden = !selected;
    self.categoryTextLabel.textColor = selected ? self.selectedIndicator.backgroundColor : [UIColor blackColor];
    [super setSelected:selected animated:animated];
    
}

/**
 *  为cell自控件赋值
 *
 *  @param category NSArray ＊
 */
- (void)setCategory:(PHCheckList *)category{
    _category = category;
    self.categoryTextLabel.text = category.typeName;
}


@end
