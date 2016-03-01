//
//  PHMsgTableMod.m
//  PersonalHealthHelper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 PH. All rights reserved.
//

#import "PHMsgTableMod.h"

@implementation PHMsgTableMod
/**
 
 author : 南方日报,
	img : http://img1.gtimg.com/health/pics/hv1/234/41/1886/122647839.jpg,
	time : 2015-07-23 10:07:24,
	id : 021088,
	tname : 综合资讯,
	title : 中国一年用16万吨抗生素 约占世界用量一半,
	tid : 1
 
 */
+(PHMsgTableMod *)modWithDict:(NSDictionary * )dict
{
    PHMsgTableMod * mod=[PHMsgTableMod new];
    mod.author=dict[@"author"];
    mod.time=dict[@"time"];
    mod.img=dict[@"img"];
    mod.ID=dict[@"id"];
    mod.tname=dict[@"tname"];
    mod.title=dict[@"title"];
    mod.tid=dict[@"tid"];
    return mod;
}
@end
