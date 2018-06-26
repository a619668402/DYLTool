//
//  NSString+base64.m
//  DYLTool
//
//  Created by sky on 2018/5/29.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "NSString+base64.h"

@implementation NSString (base64)

- (NSString *)yl_imageToBase64String:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *base64String = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64String;
}

- (UIImage *)yl_base64StringToImage:(NSString *)str {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

@end
