//
//  BaseUploadRequest.m
//  NetWorkTool
//
//  Created by sky on 2018/6/14.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseUploadRequest.h"

@interface BaseUploadRequest()

@property (nonatomic, strong) NSData *data;

@end

@implementation BaseUploadRequest

- (instancetype)initWithData:(NSData *)data {
    if (self = [super init]) {
        if (data == nil) {
            self.data = [NSData data];
        } else {
            self.data = [data mutableCopy];
        }
    }
    return self;
}

+ (instancetype)requestWithData:(NSData *)data {
    return [[self alloc] initWithData:data];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    return nil;
}

- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSString *name = @"image";
        NSString *formKey = @"image";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:self.data name:formKey fileName:name mimeType:type];
    };
}

@end
