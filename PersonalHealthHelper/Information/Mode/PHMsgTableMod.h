//
//  PHMsgTableMod.h
//  PersonalHealthHelper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHMsgTableMod : NSObject

@property (nonatomic,strong)NSString * author;
@property (nonatomic,strong)NSString * img;
@property (nonatomic,strong)NSString * time;
@property (nonatomic,strong)NSString * title;

@property (nonatomic,strong)NSNumber * tid;//分类id
@property (nonatomic,strong)NSString * tname;//分类名
@property (nonatomic,strong)NSString * ID;//条目id
+(PHMsgTableMod *)modWithDict:(NSDictionary * )dict;

@end
