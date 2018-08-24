//
//  UIButton+YLAnimate.m
//  DYLTool
//
//  Created by sky on 2018/8/22.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIButton+YLAnimate.h"

@implementation UIButton (YLAnimate)

- (void)shake:(NSTimeInterval)delay {
    CGAffineTransform top = CGAffineTransformMakeTranslation(0, 50);
    CGAffineTransform reset = CGAffineTransformIdentity;
    
    self.transform = top;
    self.alpha = 0.3;
    [UIView animateWithDuration:0.8 + delay delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = reset;
        self.alpha = 1;
    } completion:nil];
}

@end
