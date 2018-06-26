//
//  UIImage+CompressImage.h
//  DYLTool
//
//  Created by sky on 2018/6/7.
//  Copyright © 2018年 DYL. All rights reserved.
//  图片压缩

#import <UIKit/UIKit.h>

typedef UIImage JPEGImage;
typedef UIImage PNGImage;
typedef NSData JPEGData;
typedef NSData PNGData;

@interface UIImage (CompressImage)


/**
 传入图片,需要的大小,比例,返回压缩图片大小

 @param image 需要压缩的图片
 @param size 压缩后图片的大小
 @param scale 压缩比例 0.0 - 1.0
 @return 压缩后的图片
 */
+ (JPEGImage *)yl_needCompressImage:(UIImage *)image size:(CGSize)size scale:(CGFloat)scale;
+ (JPEGImage *)yl_needCompressImageData:(NSData *)imageData size:(CGSize)size scale:(CGFloat)scale;

/**
 传入图片,获取中间部分,需要的大小,压缩比例

 @param image 需要压缩的图片
 @param size 压缩后的图片大小
 @param scale 压缩的比例 0.0 - 1.0
 @return 返回新的图片
 */
+ (JPEGImage *)yl_needCenterImage:(UIImage *)image size:(CGSize)size scale:(CGFloat)scale;

/**
 png 图片转为jpeg图片

 @param pngImage 需要转为jpeg的图片
 @return 返回jpeg图片
 */
+ (JPEGImage *)yl_jpegImageToPNGImage:(PNGImage *)pngImage;
+ (JPEGImage *)yl_jpegImageWithPNGData:(PNGData *)pngData;
+ (JPEGData *)yl_jpegDataWithPNGData:(PNGData *)pngData;
+ (JPEGData *)yl_jpegDataWithPNGImage:(PNGImage *)pngImage;
@end
