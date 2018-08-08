//
//  UIView+CornerRadius.m
//  DYLTool
//
//  Created by sky on 2018/8/7.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)

- (void)yl_setCorner:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *fieldPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    CAShapeLayer *fieldLayer = [CAShapeLayer new];
    fieldLayer.frame = self.bounds;
    fieldLayer.path = fieldPath.CGPath;
    self.layer.mask = fieldLayer;
}

@end
