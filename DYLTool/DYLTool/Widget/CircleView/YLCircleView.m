//
//  YLCircleView.m
//  DYLTool
//
//  Created by sky on 2018/8/23.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLCircleView.h"

@interface YLCircleView ()
/// bgView frame
@property (nonatomic, assign, readwrite) CGRect rect;

@property (nonatomic, strong, readwrite) UIView *bgView;
@end

@implementation YLCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.layer.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.3f] CGColor];
//        self.layer.cornerRadius = 5.f;
//        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        self.rect = frame;
        self.bgViewColor = [UIColor grayColor];
        self.bottomShapeLayerColor = [UIColor whiteColor];
        self.topShareLayerColor = [UIColor redColor];
        self.circleBorderWidth = 3.f;
        self.circleWidth = 45.f;
        
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    self.bgView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    self.bgView.alpha = 0.9f;
    self.bgView.layer.backgroundColor = [self.bgViewColor CGColor];
    self.bgView.frame = CGRectMake((KScreenWidth - 85) * 0.5f, (KScreenHeight - 85) * 0.5f, 85, 85);
    self.bgView.layer.cornerRadius = 5.0f;
    self.bgView.layer.masksToBounds = YES;
    [self addSubview:self.bgView];
}

- (void)drawRect:(CGRect)rect {
    CAShapeLayer *grayCircleLayer = [CAShapeLayer layer];
    grayCircleLayer.strokeColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1].CGColor;
    grayCircleLayer.fillColor = [[UIColor clearColor] CGColor];
    grayCircleLayer.lineWidth = _circleBorderWidth;
    grayCircleLayer.path = [[UIBezierPath bezierPathWithRoundedRect:CGRectMake((85 - _circleWidth) / 2, (85 - _circleWidth) / 2, _circleWidth, _circleWidth) cornerRadius:_circleWidth * 0.5f] CGPath];
    [self.bgView.layer addSublayer:grayCircleLayer];
    
    CAShapeLayer *orangeShapeLayer = [CAShapeLayer layer];
    orangeShapeLayer.strokeColor = [[UIColor colorWithRed:0.984 green:0.153 blue:0.039 alpha:1.000] CGColor];
    orangeShapeLayer.fillColor = [UIColor clearColor].CGColor;
    orangeShapeLayer.lineWidth = _circleBorderWidth;
    orangeShapeLayer.path = [[UIBezierPath bezierPathWithRoundedRect:CGRectMake((85 - _circleWidth) / 2, (85 - _circleWidth) / 2, _circleWidth, _circleWidth) cornerRadius:_circleWidth * 0.5f] CGPath];
    orangeShapeLayer.lineDashPattern = @[@6,@3];
    [self.bgView.layer addSublayer:orangeShapeLayer];
    
    
    /// 起点动画
    CABasicAnimation * strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @(1.0);
    
    /// 终点动画
    CABasicAnimation * strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.0);
    strokeEndAnimation.toValue = @(1.0);
    
    /// 组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
    animationGroup.duration = 1.5f;
    animationGroup.repeatCount = CGFLOAT_MAX;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [orangeShapeLayer addAnimation:animationGroup forKey:nil];
}

@end
