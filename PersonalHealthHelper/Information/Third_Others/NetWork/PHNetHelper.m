//
//  PHNetHelper.m
//  personal health helper
//
//  Created by Dylan on 3/1/16.
//  Copyright © 2016 Dylan. All rights reserved.
//

#import "PHNetHelper.h"

static PHNetHelper *_shareManager = nil;

@implementation PHNetHelper


+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // AFHTTPSessionManager 单例对象，可以在程序短时间内发起多个请求时，降低系统开销
        _shareManager = [[super allocWithZone:NULL] initWithBaseURL:[NSURL URLWithString:@"https://route.showapi.com"]];// 这里使用 BaseUrl ，是让 AFNetworking 减少每次请求服务器时候，提升查找目标服务器地址的速度，而且这里建议直接使用 ip 地址。
        // 设置网络请求 SSL 功能，使用（HTTPS）时开启
        //		_shareManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        // 设置请求内容的序列化方式
        _shareManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        // 设置网络超时的时间，10秒。
        _shareManager.requestSerializer.timeoutInterval = 10;
        // 设置服务器返回数据的序列化方式
        _shareManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 设置可接受的服务器返回数据的格式
        _shareManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
        
        // 当手机处于无网络状态时，必须给出提示，不然会被拒绝。
        [self isReachToWeb];
    });
    
    
    return _shareManager;
}

+ (void)isReachToWeb {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                
                
                break;
            }
            case AFNetworkReachabilityStatusNotReachable: {
                
                NSLog(@"无网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                
                
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                
                
                break;
            }
        }
        
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


// 封装 Post 请求，成功和失败在一个 block 里面处理
+ (void)postWithParam:(NSDictionary *)params andPath:(NSString *)path andComplete:(void (^)(BOOL success, id result))complete
{
    [[self shareManager]POST:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        complete(YES, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

// 封装 Get 请求，成功和失败分开处理
+ (void)getDataWithParam:(NSDictionary *)params andPath:(NSString *)path andComplete:(void (^)(BOOL success, id result))complete {
    [[self shareManager] GET:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        complete(YES, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        complete(NO, error.localizedDescription);
    }];
}

@end
