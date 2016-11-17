//
//  LDHTTPTool.h
//  团购项目
//
//  Created by Ringo on 2016/11/17.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^requestSuccessBlock)(id responseObject);

typedef void(^requestFailureBlock)(NSError  *error);

@interface LDHTTPTool : AFHTTPSessionManager


//get
+(void)getWithURLString:(NSString*)url
            parameters:(NSDictionary*)param
           success:(requestSuccessBlock) successBlock
            failure:(requestFailureBlock) failureBlock;

//post
+(void)postWithURLString:(NSString*)url
         parameters:(NSDictionary*)param
            success:(requestSuccessBlock) successBlock
            failure:(requestFailureBlock) failureBlock;
@end


