//
//  BaseUploadRequest.h
//  NetWorkTool
//
//  Created by sky on 2018/6/14.
//  Copyright © 2018年 DYL. All rights reserved.
//

@interface BaseUploadRequest : YTKRequest

- (instancetype)initWithData:(NSData *)data;

+ (instancetype)requestWithData:(NSData *)data;

@end
