//
//  KQRCodeUtil.h
//  DYLTool
//
//  Created by sky on 2018/8/6.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
                QRCode Util
 *********************************************/
#import <Foundation/Foundation.h>

@interface KQRCodeUtil : NSObject

/**
 生成二维码图片

 @param qrSting 二维码图片内容
 @param sizeWidth 图片size (正方形)
 @param color 填充色
 @return UIImage
 */
+ (UIImage *)createQRImageString:(NSString *)qrSting sizeWidth:(CGFloat)sizeWidth fillColor:(UIColor *)color;

/**
 读取图片中二维码图片信息

 @param image 图片
 @return 二维码内容
 */
+ (NSString *)readQRCodeFromImage:(UIImage *)image;

@end
