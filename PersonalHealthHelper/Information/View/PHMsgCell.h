//
//  PHMsgCell.h
//  PersonalHealthHelper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHMsgTableMod.h"

@interface PHMsgCell : UITableViewCell

+(PHMsgCell *)cellWithTableView:(UITableView *)tableView;

-(void)configCellWithMod:(PHMsgTableMod *)mod;
@end
