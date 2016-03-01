//
//  PHMsgTableController.h
//  PersonalHealthHelper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHMsgTableView : UITableView

@property (nonatomic,strong)NSNumber * tid;

+(instancetype)phmsgTableViewWithFrame:(CGRect)frame andtid:(NSNumber *)tid;

@end
