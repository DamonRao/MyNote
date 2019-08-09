//
//  KMHTTPNetworkingContext.h
//  NetworkDemo
//
//  Created by jianq on 2017/3/28.
//  Copyright © 2017年 jianq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface KMHTTPNetworkingContext : NSObject

+(instancetype)shareContext;

/**
 添加网路请求对象

 @param network 网路请求对象
 */
-(void)addNetwork:(AFHTTPSessionManager *)network;

/**
 移除网络对象

 @param network 网络对象
 */
- (void)removeNetwork:(AFHTTPSessionManager *)network;

/**
 清楚所有请求对象
 */
-(void)clearAllNetwork;

/**
取消请求
 */
- (void)cannelAllRequest;

@end
