//
//  RequestTool.h
//  NetWorkTool
//
//  Created by sky on 2018/5/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"
#import <YTKBatchRequest.h>
#import <MJExtension.h>

typedef void(^Success_Block)(id result);
typedef void(^Failure_Block)(NSError *error);
typedef void(^CacheData_Block)(id result);

@interface RequestTool : NSObject

+ (void)sendRequest:(BaseRequest *)request resultClass:(Class)resultClass success:(Success_Block)success failure:(Failure_Block)failure;

+ (void)sendRequest:(BaseRequest *)request resultClass:(Class)resultClass cache:(CacheData_Block)cache success:(Success_Block)success failure:(Failure_Block)failure;

+ (void)sendBatchRequest:(YTKBatchRequest *)request resultClass:(NSArray *)classes success:(Success_Block)success failure:(Failure_Block)failure;

@end
