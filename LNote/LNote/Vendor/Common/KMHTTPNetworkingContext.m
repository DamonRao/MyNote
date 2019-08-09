//
//  KMHTTPNetworkingContext.m
//  NetworkDemo
//
//  Created by jianq on 2017/3/28.
//  Copyright © 2017年 jianq. All rights reserved.
//

#import "KMHTTPNetworkingContext.h"

@interface KMHTTPNetworkingContext()

@property (nonatomic, strong) NSMutableArray *networkArray;

@end

@implementation KMHTTPNetworkingContext

+ (instancetype)shareContext
{
    static KMHTTPNetworkingContext *shareContext;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareContext = [[KMHTTPNetworkingContext alloc] init];
    });
    return shareContext;
}

- (NSMutableArray *)networkArray
{
    if (!_networkArray) {
        _networkArray = [[NSMutableArray alloc] init];
    }
    return _networkArray;
}

- (void)addNetwork:(AFHTTPSessionManager *)network
{
    if (network) {
        [self.networkArray addObject:network];
    }
}

- (void)removeNetwork:(AFHTTPSessionManager *)network
{
    if (network) {
        [self.networkArray removeObject:network];
    }
}

- (void)clearAllNetwork
{
    [self.networkArray removeAllObjects];
}

- (void)cannelAllRequest
{
    for (AFHTTPSessionManager *manager in self.networkArray) {
        [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
        // 关闭session并且取消请求(session一旦被关闭了, 这个manager就没法再发送请求)
        [manager invalidateSessionCancelingTasks:YES];
    }
    [self.networkArray removeAllObjects];
}

@end
