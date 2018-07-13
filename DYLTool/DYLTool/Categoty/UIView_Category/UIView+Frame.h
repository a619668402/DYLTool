//
//  UIView+Frame.h
//  DYLTool
//
//  Created by sky on 2018/5/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

- (CGFloat)yl_left;
- (CGFloat)yl_right;
- (CGSize)yl_size;
- (CGFloat)yl_top;
- (CGFloat)yl_bottom;
- (CGFloat)yl_width;
- (CGFloat)yl_height;
- (CGFloat)yl_centerX;
- (CGFloat)yl_centerY;
- (CGFloat)yl_maxX;
- (CGFloat)yl_maxY;

- (void)yl_setLeft:(CGFloat)left;
- (void)yl_setRight:(CGFloat)right;
- (void)yl_setSize:(CGSize)size;
- (void)yl_setTop:(CGFloat)top;
- (void)yl_setBottom:(CGFloat)bottom;
- (void)yl_setWidth:(CGFloat)width;
- (void)yl_setHeight:(CGFloat)height;
- (void)yl_setCenterX:(CGFloat)centerX;
- (void)yl_setCenterY:(CGFloat)centerY;
- (void)yl_setOrigin:(CGPoint)point;
- (void)yl_setAddTop:(CGFloat)top;
- (void)yl_setAddLeft:(CGFloat)left;

@end
