//
//  BaseUrlArgumentsFilter.h
//  NetWorkTool
//
//  Created by sky on 2018/5/14.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseUrlArgumentsFilter : NSObject<YTKUrlFilterProtocol>

+ (BaseUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;

@end
