//
//  PHCheckList.h
//  PersonalHealthHelper
//
//  Created by 汪俊 on 16/3/2.
//  Copyright © 2016年 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PHDescription;

@interface PHCheckList : NSObject

@property (nonatomic, strong) NSArray<PHDescription *> *subList;

@property (nonatomic, copy) NSString *typeId;

@property (nonatomic, copy) NSString *typeName;

@end
