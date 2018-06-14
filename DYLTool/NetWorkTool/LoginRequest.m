//
//  LoginRequest.m
//  NetWorkTool
//
//  Created by sky on 2018/5/14.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (NSString *)requestUrl {
    return @"agent_api/pwd_login";
//    return @"agent_api/order_list";
}

- (NSInteger)cacheTimeInSeconds {
    return NSIntegerMax;
}

@end
