//
//  UIImage+Tool.h
//  DYLTool
//
//  Created by sky on 2018/6/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)

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

@end
