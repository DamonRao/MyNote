//
//  KMHTTPNetworking.m
//  NetworkDemo
//
//  Created by jianq on 2017/3/28.
//  Copyright © 2017年 jianq. All rights reserved.
//

#import "KMHTTPNetworking.h"
#import "KMHTTPNetworkingContext.h"
@interface KMHTTPNetworking()
{
    AFHTTPSessionManager *_manager;
    AFURLSessionManager *_downloadManager;
}

@end

@implementation KMHTTPNetworking

+ (void)setReachabilityStatusChange:(void (^)(NSInteger))block
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        block(status);
    }];
    [[AFNetworkReachabilityManager sharedManager]  startMonitoring];
}

- (void)sendPostRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    if (self.isWorkCircle) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    if (_headerFields) {
        [_headerFields enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
   
    if(self.requestTimeoutInterval>0)
    {
        [manager.requestSerializer setTimeoutInterval:self.requestTimeoutInterval];
    }
    
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            success(responseObject);
        }else
        {
            if (failure) {
                failure(@"请求失败");
            }
        }
        
        [[KMHTTPNetworkingContext shareContext] removeNetwork:manager];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[KMHTTPNetworkingContext shareContext] removeNetwork:manager];
        
        if (error.code == -999) {
            return ;
        }
        if (failure) {
            failure(error.localizedDescription);
        }
        
        
    }];
    _manager = manager;
    
    [[KMHTTPNetworkingContext shareContext] addNetwork:manager];
    
}


- (void)cannelRequest
{
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 关闭session并且取消请求(session一旦被关闭了, 这个manager就没法再发送请求)
    [_manager invalidateSessionCancelingTasks:YES];
    _manager = nil;
   
}


- (void)sendHTTPReustURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/octet-stream",@"text/plain",@"text/javascript",@"multipart/form-data",@"text/html",@"image/gif",@"text/json", nil];
    
    
    
    if (_headerFields) {
        [_headerFields enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    

    
    if(self.requestTimeoutInterval>0)
    {
        [manager.requestSerializer setTimeoutInterval:self.requestTimeoutInterval];
        
    }else
    {
         [manager.requestSerializer setTimeoutInterval:100];
    }
    
   
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        if(self.isLogin)
        {
            
        }
        id dict;
        if ([responseObject isKindOfClass:[NSData class]]) {
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        }else {
            //转成字典
            dict = (NSDictionary *)responseObject;
        }
        
        success(dict);
        
        
        [[KMHTTPNetworkingContext shareContext] removeNetwork:manager];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[KMHTTPNetworkingContext shareContext] removeNetwork:manager];
        
        if (error.code == -999) {
            failure(@"false");
            return ;
        }
        if (failure) {
            failure(error.localizedDescription);
        }
        
        
    }];
    _manager = manager;
    
    [[KMHTTPNetworkingContext shareContext] addNetwork:manager];
}

@end

