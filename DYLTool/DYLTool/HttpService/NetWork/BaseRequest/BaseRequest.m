//
//  BaseRequest.m
//  NetWorkTool
//
//  Created by sky on 2018/5/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseRequest.h"

@interface BaseRequest()

@property (nonatomic, strong) NSMutableDictionary *parameter; // 请求参数

@property (nonatomic, strong) NSString *url; // 请求URL

@property (nonatomic, assign) YTKRequestMethod method; // 请求方法

@end

@implementation BaseRequest

+ (instancetype)requestWithParameter:(NSDictionary *)parameter requestMethod:(YTKRequestMethod)method {
    return [[self alloc] initWithParameter:parameter requestMethod:method];
}

- (instancetype)initWithParameter:(NSDictionary *)parameter requestMethod:(YTKRequestMethod)method {
    if (self = [super init]) {
        if (parameter == nil) {
            self.parameter = [NSMutableDictionary dictionary];
        } else {
            self.parameter = [parameter copy];
        }
        self.method = method;
    }
    return self;
}

+ (instancetype)requestWithUrl:(NSString *)url parameter:(NSDictionary *)parameter requestMethod:(YTKRequestMethod)method{
    return [[self alloc] initWithUrl:url parameter:parameter requestMethod:method];
}

- (instancetype)initWithUrl:(NSString *)url parameter:(NSDictionary *)parameter requestMethod:(YTKRequestMethod)method{
    if (self = [super init]) {
        if (url.length == 0 || url == nil) {
            KLog(@"request URL is must not be null");
            return nil;
        } else {
            self.url = [url copy];
        }
        if (parameter == nil) {
            self.parameter = [NSMutableDictionary dictionary];
        } else {
            self.parameter = [parameter copy];
        }
        self.method = method;
    }
    return self;
}

#pragma mark ----- YTKRequest 方法 -----
/**
 请求方式

 @return YTKRequestMethod ENUM
 */
- (YTKRequestMethod)requestMethod {
    return self.method;
}

/**
 请求URL

 @return 请求URL地址
 */
- (NSString *)requestUrl {
    return self.url == nil ? @"" : self.url;
}

/**
 网络请求的超时时间

 @return 请求超时时间 单位:s  默认60s
 */
- (NSTimeInterval)requestTimeoutInterval {
    return 30;
}

/**
 请求参数

 @return NSDictionary
 */
- (id)requestArgument {
    return self.parameter;
}

/**
 是否忽略缓存

 @return YES: 忽略  NO: 不忽略
 */
- (BOOL)ignoreCache {
    return YES;
}

/**
 设置缓存时间

 @return 缓存时间 单位:s
 */
- (NSInteger)cacheTimeInSeconds {
    return -1;
}

/**
 设置请求头

 @return 字典 key: 请求头 value: 请求头值
 */
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    return @{@"Authorization-tigo":[NSString stringWithFormat:@"Bearer %@", @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1YV9pZCI6MjgsInNlY3JldCI6InRpZ29uZXR3b3JrIn0.RahIHRKkvSuk_DXR8LtiSnQKdFJAHZ-c19IN0Uv2muQ"]};
}


@end
