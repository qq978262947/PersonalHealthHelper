//
//  PHHMModel.m
//  personal health helper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 Dylan. All rights reserved.
//

#import "PHHMModel.h"

@implementation PHHMModel

+(PHHMModel *)modWithDict:(NSDictionary *)dict
{
    PHHMModel * mod=[PHHMModel new];
    mod.ID=dict[@"id"];
    mod.name=dict[@"name"];
    return mod;
}
@end
