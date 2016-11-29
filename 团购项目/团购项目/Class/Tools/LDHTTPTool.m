//
//  LDHTTPTool.m
//  团购项目
//
//  Created by Ringo on 2016/11/17.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDHTTPTool.h"

@implementation LDHTTPTool

//创建单例
+(instancetype)sharedTool{
    
    static LDHTTPTool *manager=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager= [[LDHTTPTool alloc]initWithBaseURL:[NSURL URLWithString:@"http://123.57.141.249:8080/beautalk/" ]];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
    });
    return manager;
}
//get

+(void)getWithURLString:(NSString *)url parameters:(NSDictionary *)param success:(requestSuccessBlock)successBlock failure:(requestFailureBlock)failureBlock{

    [[LDHTTPTool sharedTool]GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


//post
+(void)postWithURLString:(NSString *)url parameters:(NSDictionary *)param success:(requestSuccessBlock)successBlock failure:(requestFailureBlock)failureBlock{
    
 
    [[LDHTTPTool sharedTool] POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }

    }];

}

@end
