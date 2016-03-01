//
//  PHMsgCell.m
//  PersonalHealthHelper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 PH. All rights reserved.
//

#import "PHMsgCell.h"
#import "UIImageView+WebCache.h"
@interface PHMsgCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgImageView;
@property (weak, nonatomic) IBOutlet UILabel *autherLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tnameLabel;

@end
@implementation PHMsgCell

+(PHMsgCell *)cellWithTableView:(UITableView *)tableView
{
    NSString * identifity=NSStringFromClass([self class]);
    UINib * nib=[UINib nibWithNibName:identifity bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifity];
    return [tableView dequeueReusableCellWithIdentifier:identifity];
}
-(void)configCellWithMod:(PHMsgTableMod *)mod
{
    self.titleLabel.text=mod.title;
    [self.imgImageView sd_setImageWithURL:[NSURL URLWithString:mod.img]];
    self.autherLabel.text=mod.author;
    self.timeLabel.text=mod.time;
    self.tnameLabel.text=mod.tname;
}

@end
