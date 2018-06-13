//
//  RACNetWork.m
//  NetWorkTool
//
//  Created by sky on 2018/6/1.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "RACNetWork.h"

@implementation RACNetWork


+ (RACSignal *)rac_Action:(BaseRequest *)request {
    // TODO 判断网络可用不可用,不可用返回
    if (0 != 0) {
        return [RACSignal error:[NSError errorWithDomain:NerworkErrorDomain code:NetWorkErrorCode userInfo:@{NetWorkError:NetWorkErrorInfo}]];
    }
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [subscriber sendNext:@"Test----------"];
            [subscriber sendNext:request.responseString];
            [subscriber sendNext:@"-----------Test"];
            [subscriber sendCompleted];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [subscriber sendError:[NSError errorWithDomain:NetWorkFailureDomain code:NetWorkFailureCode userInfo:@{NetWorkFialure:NetWorkErrorInfo}]];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"----%s----, 信号被销毁", __func__);
        }];
    }];
}

@end
