//
//  AnimateView.m
//  DYLTool
//
//  Created by sky on 2019/2/25.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "AnimateView.h"

@interface AnimateView()<CAAnimationDelegate>

@end

@implementation AnimateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews {
    self.text = @"测试Label";
    self.backgroundColor = green_color;
    self.textAlignment = NSTextAlignmentLeft;
    self.font = [UIFont systemFontOfSize:(arc4random() % 11 + 6)];
    self.textColor = [UIColor redColor];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([anim isKindOfClass:[CABasicAnimation class]]) {
        CABasicAnimation *animation = (CABasicAnimation *)anim;
        if ([animation.keyPath isEqualToString:@"transform.scale"]) {
            [self translateAnimate];
        } else if ([animation.keyPath isEqualToString:@"position.y"]) {
            [self rotationAnimate];
        }
    }
}

- (void)scaleAnimate {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = 3;
    anim.repeatCount = 1;
    anim.delegate = self;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.fromValue = @(0.1);
    anim.toValue = @(1.5);
    [self.layer addAnimation:anim forKey:@"scaleAnimate"];
}

- (void)translateAnimate {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
    anim.duration = 0.5;
    anim.repeatCount = 1;
    anim.delegate = self;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.toValue = @(self.layer.position.y - 30 * 2);
    [self.layer addAnimation:anim forKey:@"translateAnimate"];
}


- (void)rotationAnimate {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.fromValue = @(0);
    anim.toValue = @(-M_PI_2);
    
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    anim1.toValue = @(self.frame.origin.x - self.frame.size.width / 2);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 2;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.repeatCount = 1;
    group.animations = @[anim, anim1];
    
    [self.layer addAnimation:group forKey:@"rotationAnimate"];
    
}
@end
