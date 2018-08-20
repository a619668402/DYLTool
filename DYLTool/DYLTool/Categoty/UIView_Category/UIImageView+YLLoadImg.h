//
//  UIImageView+LoadImg.h
//  DYLTool
//
//  Created by sky on 2018/6/25.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
                图片加载分类
 *********************************************/
#import <UIKit/UIKit.h>

@interface UIImageView (YLLoadImg)

/**
 图片加载

 @param urlStr 图片路径
 @param placeHolderImgStr 占位图名称
 */
- (void)yl_loadImgWithUrlStr:(NSString *)urlStr placeHolderImgStr:(NSString *)placeHolderImgStr;

@end
