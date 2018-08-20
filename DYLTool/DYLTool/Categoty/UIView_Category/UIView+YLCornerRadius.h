//
//  UIView+CornerRadius.h
//  DYLTool
//
//  Created by sky on 2018/8/7.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
            设置指定位置圆角
 *********************************************/
#import <UIKit/UIKit.h>

@interface UIView (YLCornerRadius)

- (void)yl_setCorner:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii;

@end
