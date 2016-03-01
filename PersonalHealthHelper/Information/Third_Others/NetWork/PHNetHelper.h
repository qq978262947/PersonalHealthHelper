//
//  PHNetHelper.h
//  personal health helper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 Dylan. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface PHNetHelper :AFHTTPSessionManager
// 封装 Get 请求，成功和失败分开处理
+ (void)getDataWithParam:(NSDictionary *)params andPath:(NSString *)path andComplete:(void (^)(BOOL success, id result))complete;

// 封装 Post 请求，成功和失败在一个 block 里面处理
+ (void)postWithParam:(NSDictionary *)params andPath:(NSString *)path andComplete:(void (^)(BOOL success, id result))complete;
@end
