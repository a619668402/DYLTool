//
//  ArrowLabel.m
//  DYLTool
//
//  Created by sky on 2018/7/20.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "ArrowLabel.h"

@interface ArrowLabel ()
/// 遮罩
@property (nonatomic, strong) CAShapeLayer *maskLayer;
/// 路径
@property (nonatomic, strong) UIBezierPath *borderPath;

@end

@implementation ArrowLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 初始化遮罩
        self.maskLayer = [CAShapeLayer layer];
        // 设置遮罩
        [self.layer setMask:_maskLayer];
        // 初始化路径
        self.borderPath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:5.0f];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    /*
    // 设置 path 起点
    [self.borderPath moveToPoint:CGPointMake(3, 10)];
    // 箭头
    [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width / 2 - 8, 10)];
    [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width / 2 - 3, 5)];
    // 圆尖角
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width / 2 + 3, 5) controlPoint:CGPointMake(self.bounds.size.width / 2, 0)];
    [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width / 2 + 8, 10)];
    // 右上角
    [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width - 3, 10)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width, 13) controlPoint:CGPointMake(self.bounds.size.width, 0)];
    [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - 3)];
    // 右下角
    [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - 3)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width - 3, self.bounds.size.height) controlPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width - 3, self.bounds.size.height)];
    // 左下角
    [self.borderPath addLineToPoint:CGPointMake(3, self.bounds.size.height)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(0, self.bounds.size.height - 3) controlPoint:CGPointMake(0, self.bounds.size.height)];
    [self.borderPath addLineToPoint:CGPointMake(0, self.bounds.size.height - 3)];
    // 左上角
    [self.borderPath addLineToPoint:CGPointMake(0, 13)];
    [self.borderPath addQuadCurveToPoint:CGPointMake(3, 10) controlPoint:CGPointMake(0, 10)];
    [self.borderPath addLineToPoint:CGPointMake(3, 10)];
    self.maskLayer.path = self.borderPath.CGPath;
     */
    
    self.maskLayer.path = self.borderPath.CGPath;
}

@end
