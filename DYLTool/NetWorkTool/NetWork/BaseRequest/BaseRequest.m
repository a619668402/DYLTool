//
//  BaseRequest.m
//  NetWorkTool
//
//  Created by sky on 2018/5/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseRequest.h"

@interface BaseRequest()

@property (nonatomic, strong) NSMutableDictionary *parameter;

@property (nonatomic, assign) YTKRequestMethod method;

@end

@implementation BaseRequest

+ (instancetype)requestWithParameter:(NSDictionary *)parameter requestMethod:(YTKRequestMethod)method{
    return [[self alloc] initWithParameter:parameter requestMethod:method];
}

- (instancetype)initWithParameter:(NSDictionary *)parameter requestMethod:(YTKRequestMethod)method{
    if (self = [super init]) {
        if (parameter == nil) { 
            self.parameter = [NSMutableDictionary dictionary];
        } else {
            self.parameter = [parameter mutableCopy];
        }
        self.method = method;
    }
    return self;
}

// 请求方式 默认 GET 请求
- (YTKRequestMethod)requestMethod {
    return self.method;
}

// 请求参数
- (id)requestArgument {
    return self.parameter;
}

@end
