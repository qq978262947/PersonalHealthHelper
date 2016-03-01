//
//  PHBtnsBar.h
//  PersonalHealthHelper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHBtnsBar;
@protocol PHBtnsBarDelegate <NSObject>

-(void)phBtnBar:(PHBtnsBar *)bar btnTouchWihtTag:(NSInteger)tag;

@end

@interface PHBtnsBar : UIView

@property (nonatomic,strong)NSArray * nameArray;

+(instancetype)btnsBarWithFrame:(CGRect)frame andNameArray:(NSArray *)nameArray;

@property (nonatomic,assign)NSInteger selectNumber;

@property (nonatomic,strong)id<PHBtnsBarDelegate> delegate;

@end
