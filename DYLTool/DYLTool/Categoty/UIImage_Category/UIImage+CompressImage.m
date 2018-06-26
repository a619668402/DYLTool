//
//  UIImage+CompressImage.m
//  DYLTool
//
//  Created by sky on 2018/6/7.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIImage+CompressImage.h"

@implementation UIImage (CompressImage)

+ (JPEGImage *)yl_needCompressImage:(UIImage *)image size:(CGSize)size scale:(CGFloat)scale {
    JPEGImage *newImage = nil;
    // 创建画板
    UIGraphicsBeginImageContext(size);
    // 写入图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 得到新的图片
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 释放画板
    UIGraphicsEndImageContext();
    // 比例压缩
    newImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, scale)];
    return newImage;
}

+ (JPEGImage *)yl_needCompressImageData:(NSData *)imageData size:(CGSize)size scale:(CGFloat)scale {
    UIImage *image = [UIImage imageWithData:imageData];
    return [UIImage yl_needCompressImage:image size:size scale:scale];
}

// 暂未实现裁剪中间
+ (JPEGImage *)yl_needCenterImage:(UIImage *)image size:(CGSize)size scale:(CGFloat)scale {
    JPEGImage *newImage = nil;
    // 创建画板
    UIGraphicsBeginImageContext(size);
    // 写入图片,在中间
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 释放画板
    UIGraphicsEndImageContext();
    // 比例压缩
    newImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, scale)];
    return newImage;
}

+ (JPEGImage *)yl_jpegImageToPNGImage:(PNGImage *)pngImage {
    return [UIImage yl_needCompressImage:pngImage size:pngImage.size scale:1.0];
}

+ (JPEGImage *)yl_jpegImageWithPNGData:(PNGData *)pngData {
    PNGImage *pngImage = [UIImage imageWithData:pngData];
    return [UIImage yl_needCompressImage:pngImage size:pngImage.size scale:1.0];
}

+ (JPEGData *)yl_jpegDataWithPNGData:(PNGData *)pngData {
    return UIImageJPEGRepresentation([UIImage yl_jpegImageWithPNGData:pngData], 1.0);
}

+ (JPEGData *)yl_jpegDataWithPNGImage:(PNGImage *)pngImage {
    return UIImageJPEGRepresentation(pngImage, 1.0);
}
@end
