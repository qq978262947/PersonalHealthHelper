//
//  PHCheckList.m
//  PersonalHealthHelper
//
//  Created by 汪俊 on 16/3/2.
//  Copyright © 2016年 PH. All rights reserved.
//

#import "PHCheckList.h"
#import "PHDescription.h"

@implementation PHCheckList

+ (NSDictionary *)objectClassInArray{
    return @{@"subList" : [PHDescription class]};
}

@end
