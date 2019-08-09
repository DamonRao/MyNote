//
//  KMHTTPNetworking.h
//  NetworkDemo
//
//  Created by jianq on 2017/3/28.
//  Copyright © 2017年 jianq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

typedef enum {
    HTTPMethodPOST = 0,
    HTTPMethodGET
} HTTPMethod;

@interface KMHTTPNetworking : NSObject

/**
 检测网络状态
 
 @param block 网络状态回调
 */
+ (void)setReachabilityStatusChange:(void(^)(NSInteger status))block;

/**
 *  HTTP请求头参数
 */
@property (nonatomic, strong) NSDictionary *headerFields;


/**
 请求超时时间 默认为20秒
 */
@property (nonatomic, assign) NSUInteger requestTimeoutInterval;


/**
 是否为工作圈，默认为NO，工作圈接口比较特殊，需要定制
 */
@property (nonatomic, assign) BOOL isWorkCircle;

@property (nonatomic, assign) BOOL isLogin;
/**
 取消网络请求
 */
- (void)cannelRequest;

/**
 POST请求 改进
 
 @param URLString 请求URL
 @param parameters 请求Body参数
 @param success 请求成功回调
 @param failure 请求失败回调
 */
- (void)sendPostRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSString *errorReason))failure;

- (void)sendHTTPReustURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSString *))failure;
@end

