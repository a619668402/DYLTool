//
//  UIView+Frame.m
//  DYLTool
//
//  Created by sky on 2018/5/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)yl_left
{
    return self.frame.origin.x;
}

- (CGFloat)yl_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)yl_top
{
    return self.frame.origin.y;
}

- (CGFloat)yl_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGSize)yl_size{
    return self.frame.size;
}

- (CGFloat)yl_width
{
    return self.frame.size.width;
}

- (CGFloat)yl_height
{
    return self.frame.size.height;
}

- (CGFloat)yl_centerX
{
    return self.center.x;
}

- (CGFloat)yl_centerY
{
    return self.center.y;
}

- (CGFloat)yl_maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)yl_maxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)yl_setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)yl_setRight:(CGFloat)right;
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (void)yl_setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)yl_setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)yl_setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)yl_setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)yl_setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)yl_setOrigin:(CGPoint)point
{
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
}

- (void)yl_setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (void)yl_setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (void)yl_setAddTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y += top;
    self.frame = frame;
}

- (void)yl_setAddLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x += left;
    self.frame = frame;
}

@end
