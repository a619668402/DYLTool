//
//  NSString+base64.h
//  DYLTool
//
//  Created by sky on 2018/5/29.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (base64)


/**
 UIImage 转 Base64 字符串

 @param image 图片
 @return <#return value description#>
 */
- (NSString *)yl_imageToBase64String:(UIImage *)image;


/**
 base64 字符串转 UIImage

 @param str base64 字符串
 @return <#return value description#>
 */
- (UIImage *)yl_base64StringToImage:(NSString *)str;

@end
