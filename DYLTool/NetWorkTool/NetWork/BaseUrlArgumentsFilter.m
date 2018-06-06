//
//  BaseUrlArgumentsFilter.m
//  NetWorkTool
//
//  Created by sky on 2018/5/14.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseUrlArgumentsFilter.h"

@interface BaseUrlArgumentsFilter()

@property (nonatomic, strong) NSDictionary *arguments;

@end

@implementation BaseUrlArgumentsFilter

+ (BaseUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments {
    return [[self alloc] initWithArguments:arguments];
}

- (id)initWithArguments:(NSDictionary *)arguments {
    if (self = [super init]) {
        self.arguments = arguments;
    }
    return self;
}

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request {
    return nil;
}

- (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString appendParameters:(NSDictionary *)parameters {
    NSString *paraUrlString = AFQueryStringFromParameters(parameters);
    if (!(paraUrlString.length > 0)) {
        return originUrlString;
    }
    BOOL useDummyURL = NO;
    static NSString *dummyUrl = nil;
    NSURLComponents *components = [NSURLComponents componentsWithString:originUrlString];
    if (!components) {
        useDummyURL = YES;
        if (!dummyUrl) {
            dummyUrl = [YTKNetworkConfig sharedConfig].baseUrl;
        }
        components = [NSURLComponents componentsWithString:dummyUrl];
    }
    NSString *queryString = components.query ?: @"";
    NSString *newQueryString = [queryString stringByAppendingFormat:queryString.length > 0 ? @"&%@" : @"%@", paraUrlString];
    
    components.query = newQueryString;
    
    if (useDummyURL) {
        return [components.URL.absoluteString substringFromIndex:dummyUrl.length - 1];
    } else {
        return components.URL.absoluteString;
    }
}

@end
