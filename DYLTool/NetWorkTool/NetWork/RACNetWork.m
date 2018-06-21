//
//  RACNetWork.m
//  NetWorkTool
//
//  Created by sky on 2018/6/1.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "RACNetWork.h"

@implementation RACNetWork

+ (RACSignal *)rac_Action:(BaseRequest *)request resultClass:(Class)resultClass {
    // TODO 判断网络状态,不可用返回
    if (0 != 0) {
        return [RACSignal error:[NSError errorWithDomain:NerworkErrorDomain code:NetWorkErrorCode userInfo:@{NetWorkError:NetWorkErrorInfo}]];
    }
    return [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"\n 请求url %@/%@\n 请求参数 %@\n 结果 %@\n", [YTKNetworkConfig sharedConfig].baseUrl, request.requestUrl, request.requestArgument, request.responseJSONObject);
            //            NSLog(@"%@ \n ,结果: %@ \n", request.description, request.responseJSONObject);
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:request.responseData];
            if (resultClass != nil) { // 泛型不为空
                if ([response.code isEqualToString:CODE_SUCCESS]) { // 请求成功
                    [subscriber sendNext:[resultClass mj_objectWithKeyValues:response.data]];
                } else { // 请求信息有误
                    [subscriber sendError:[NSError errorWithDomain:NetWorkRequestErrorDomain code:NetWorkRequestErrorCode userInfo:@{NetWorkRequestError: response.msg}]];
                }
            } else { // 泛型为空
                if ([response.code isEqualToString:CODE_SUCCESS]) { // 请求成功
                    [subscriber sendNext:response.data];
                } else { // 请求信息有误
                    [subscriber sendError:[NSError errorWithDomain:NetWorkRequestErrorDomain code:NetWorkRequestErrorCode userInfo:@{NetWorkRequestError: response.msg}]];
                }
            }
            [subscriber sendCompleted];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [subscriber sendError:[NSError errorWithDomain:NetWorkFailureDomain code:NetWorkFailureCode userInfo:@{NetWorkFailure:NetWorkErrorInfo}]];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"----%s----, 信号被销毁", __func__);
        }];
    }] timeout:30 onScheduler:[RACScheduler mainThreadScheduler]];
}

+ (RACSignal *)rac_BatchAction:(YTKBatchRequest *)batchRequest resultClasses:(NSArray<Class> *)resultClasses {
    // TODO 判断网络状态,不可用返回
    if (0 != 0) {
        return [RACSignal error:[NSError errorWithDomain:NetWorkError code:NetWorkErrorCode userInfo:@{NetWorkError:NetWorkErrorInfo}]];
    }
    return [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
            NSArray *requests = batchRequest.requestArray;
            NSMutableArray *results = [NSMutableArray arrayWithCapacity:requests.count];
            for (int i = 0; i < requests.count; i ++) {
                BaseRequest *request = [requests objectAtIndex:i];
                Class clazz = [resultClasses objectAtIndex:i];
                BaseResponse *response = [BaseResponse mj_objectWithKeyValues:request.responseJSONObject];
                if (clazz != nil) { // 泛型不为空
                    if ([response.code isEqualToString:CODE_SUCCESS]) {
                        [results addObject:[clazz mj_objectWithKeyValues:response.data]];
                    } else {
                        [subscriber sendError:[NSError errorWithDomain:NetWorkRequestErrorDomain code:NetWorkRequestErrorCode userInfo:@{NetWorkRequestError:response.msg}]];
                    }
                } else { // 泛型为空
                    if ([response.code isEqualToString:CODE_SUCCESS]) {
                        [results addObject:response.data];
                    } else {
                        [subscriber sendError:[NSError errorWithDomain:NetWorkRequestErrorDomain code:NetWorkRequestErrorCode userInfo:@{NetWorkRequestError:response.msg}]];
                    }
                }
            }
            [subscriber sendNext:results];
            [subscriber sendCompleted];
        } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
            [subscriber sendError:[NSError errorWithDomain:NetWorkFailureDomain code:NetWorkFailureCode userInfo:@{NetWorkFailure:NetWorkFailureInfo}]];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"----%s----, 信号被销毁", __func__);
        }];
    }] timeout:30 onScheduler:[RACScheduler mainThreadScheduler]];
}

@end
