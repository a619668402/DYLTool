//
//  UIImage+Tool.m
//  DYLTool
//
//  Created by sky on 2018/6/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIImage+YLTool.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MacrosTools.h"

@implementation UIImage (YLTool)

+ (UIImage *)yl_resizableImage:(NSString *)imgName {
    UIImage *image = [UIImage imageNamed:imgName];
    return [self yl_resizableImage:imgName capInsets:UIEdgeInsetsMake(image.size.height * 0.5f, image.size.width * 0.5f, image.size.height * 0.5f, image.size.width * 0.5f)];
}

+ (UIImage *)yl_resizableImage:(NSString *)imgName capInsets:(UIEdgeInsets)capInsets {
    UIImage *image = [UIImage imageNamed:imgName];
    return [image resizableImageWithCapInsets:capInsets];
}

+ (UIImage *)yl_imageAlwaysShowOriginalImageWithImageName:(NSString *)imgName {
    UIImage *image = [UIImage imageNamed:imgName];
    if ([image respondsToSelector:@selector(imageWithRenderingMode:)]) {
        return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        return image;
    }
}

+ (UIImage *)yl_thunbnailImageForVideo:(NSURL *)videlURL atTime:(NSTimeInterval)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videlURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        KLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

+ (UIImage *)yl_screenShot {
    // 1. 获取到窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 2. 开始上下文
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, YES, 0);
    
    // 3. 将 window 中的内容绘制输出到当前上下文
    [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];
    
    // 4. 获取图片
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5. 关闭上下文
    UIGraphicsEndImageContext();
    
    return screenShot;
}

@end
