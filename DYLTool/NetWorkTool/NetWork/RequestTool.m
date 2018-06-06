//
//  RequestTool.m
//  NetWorkTool
//
//  Created by sky on 2018/5/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "RequestTool.h"

@implementation RequestTool

+ (void)sendRequest:(BaseRequest *)request resultClass:(Class)resultClass success:(Success_Block)success failure:(Failure_Block)failure{
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (resultClass != nil) {
            id resultObject = [resultClass mj_objectWithKeyValues:request.responseJSONObject];
            if (success) {
                success(resultObject);
            }
        } else {
            if (success) {
                success(request.responseString);
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request.error);
        }
    }];
}

+ (void)sendRequest:(BaseRequest *)request resultClass:(Class)resultClass cache:(CacheData_Block)cache success:(Success_Block)success failure:(Failure_Block)failure {
    if ([request loadCacheWithError:nil]) {
        if (cache) {
            if (resultClass != nil) {
                id resultObject = [resultClass mj_objectWithKeyValues:request.responseJSONObject];
                cache(resultObject);
            }
        }
    }
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (resultClass != nil) {
            id resultObject = [resultClass mj_objectWithKeyValues:request.responseJSONObject];
            if (success) {
                success(resultObject);
            }
        } else {
            if (success) {
                success(request.responseString);
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure) {
            failure(request.error);
        }
    }];
}

+ (void)sendBatchRequest:(YTKBatchRequest *)request resultClass:(NSArray *)classes success:(Success_Block)success failure:(Failure_Block)failure {
    [request startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        NSMutableArray *result = [NSMutableArray array];
        for (int i = 0; i < requests.count; i ++) {
            Class resultClass = i < classes.count ? classes[i] : nil;
            BaseRequest *baseRequest = (BaseRequest *)requests[i];
            if (resultClass != nil) {
                id resultObject = [resultClass mj_objectWithKeyValues:baseRequest.responseJSONObject];
                [result addObject:resultObject];
            } else {
                [result addObject:baseRequest.responseString];
            }
        }
        if (success) {
            success(result);
        }
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        if (failure) {
            failure(batchRequest.failedRequest.error);
        }
    }];
}

@end
