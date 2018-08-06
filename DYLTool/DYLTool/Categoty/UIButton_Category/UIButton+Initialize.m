//
//  UIButton+Initialize.m
//  DYLTool
//
//  Created by sky on 2018/8/2.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIButton+Initialize.h"

@implementation UIButton (Initialize)

+ (instancetype)yl_initWithFrame:(CGRect)frame buttonType:(UIButtonType)type title:(NSString *)btnTitle backgroundColor:(UIColor *)color target:(id)target selector:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:type];
    btn.frame = frame;
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    btn.layer.backgroundColor = color.CGColor;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
