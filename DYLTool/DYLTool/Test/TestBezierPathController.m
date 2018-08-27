//
//  TestBezierPathController.m
//  DYLTool
//
//  Created by sky on 2018/8/24.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestBezierPathController.h"

@interface TestBezierPathController ()

@end

@implementation TestBezierPathController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initViews {
    [super yl_initViews];
    
//    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.frame = self.view.bounds;
//
//    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)) radius:200/2 -1 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    layer.path = path1.CGPath;
//    layer.strokeColor = [[UIColor redColor] CGColor];
////    layer.fillColor = [[UIColor blackColor] CGColor];
//    layer.fillColor = nil;
//    [self.view.layer addSublayer:layer];
//
//    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//    strokeStartAnimation.fromValue = @(0.9);
//    strokeStartAnimation.toValue = @(0.5);
//
//    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    strokeStartAnimation.fromValue = @(0.8);
//    strokeStartAnimation.toValue = @(0.5);
//
//    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.fromValue = @(0);
//    rotationAnimation.toValue = @(M_PI * 2);
//
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.duration = 5;
//    group.removedOnCompletion = NO;
//    group.fillMode = kCAFillModeForwards;
//    group.animations = @[strokeStartAnimation, strokeEndAnimation];
//    [layer addAnimation:group forKey:nil];

    CAShapeLayer * circle = [CAShapeLayer layer];
    circle.frame = self.view.bounds;
    //
    UIBezierPath  * circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)) radius:100 startAngle:M_PI / 4 endAngle:M_PI / 2 clockwise:YES];
    circle.path = circlePath.CGPath;
    circle.strokeColor = [UIColor blueColor].CGColor;
    circle.fillColor = nil;
    [self.view.layer addSublayer:circle];
    //通过圆的strokeStart 改变来进行改变
    CABasicAnimation * strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(0.2);
    strokeStartAnimation.toValue = @(0);
    //通过圆的strokeEnd 改变来进行改变
    CABasicAnimation * strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(1);
    strokeEndAnimation.toValue = @(0.5);
    //通过圆的transform.rotation.z 改变来进行改变
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(-M_PI * 2);
    //组合动画
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.duration = 20;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.animations = @[strokeStartAnimation,strokeEndAnimation,rotationAnimation];
//    [circle addAnimation:group forKey:nil];
}

@end
