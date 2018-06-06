//
//  BaseRequest.h
//  NetWorkTool
//
//  Created by sky on 2018/5/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YTKRequest.h"

@interface BaseRequest : YTKRequest

/**
 * @param parameter 请求参数
 * @return YTKRequest 对象
 */
+ (instancetype)requestWithParameter:(NSDictionary *)parameter requestMethod:(YTKRequestMethod)method;

/**
 * @param parameter 请求参数
 * @return YTKRequest 对象
 */
- (instancetype)initWithParameter:(NSDictionary *)parameter requestMethod:(YTKRequestMethod)method; 

@end
