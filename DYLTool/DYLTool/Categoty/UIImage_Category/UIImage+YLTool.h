//
//  UIImage+Tool.h
//  DYLTool
//
//  Created by sky on 2018/6/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YLTool)

/**
 根据图片名返回一张能够自由拉伸的图片(从中间拉伸)

 */
+ (UIImage *)yl_resizableImage:(NSString *)imgName;
+ (UIImage *)yl_resizableImage:(NSString *)imgName capInsets:(UIEdgeInsets)capInsets;


/**
 返回一张未被渲染的图片

 @param imgName 图片名
 @return UIImage
 */
+ (UIImage *)yl_imageAlwaysShowOriginalImageWithImageName:(NSString *)imgName;

/**
 获取视频某个时间的帧图片

 @param videlURL 视频URL
 @param time 时间
 @return UIImage
 */
+ (UIImage *)yl_thunbnailImageForVideo:(NSURL *)videlURL atTime:(NSTimeInterval)time;

/**
 获取屏幕截图

 @return UIImage
 */
+ (UIImage *)yl_screenShot;

+ (UIImage *)yl_imageWithColor:(UIColor *)color;

+ (UIImage *)yl_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornetRadius;

/**
 绘制一张图片并以UIImage的形式返回

 @param size 要绘制的图片的size,宽高均不能为0
 @param opaque 图片是否不透明,YES: 不透明, NO: 半透明
 @param scale 图片倍数,0表示取当前屏幕倍数
 @param actionBlock 实际图片绘制操作,这里只管绘制,不用手动生成image
 @return 返回绘制完的图片
 */
+ (UIImage *)yl_imageWithSize:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale actions:(void (^)(CGContextRef contextRef))actionBlock;

@end
