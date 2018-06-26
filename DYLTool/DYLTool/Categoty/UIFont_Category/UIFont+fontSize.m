//
//  UIFont+fontSize.m
//  DYLTool
//
//  Created by sky on 2018/5/29.
//  Copyright © 2018年 DYL. All rights reserved.
//
//  字体适配

#import "UIFont+fontSize.h"
#import <objc/runtime.h>

#define UIScreenWidth 414 // 定义参照屏幕的宽度

@implementation UIFont (fontSize)

+ (void)load {
    // 新方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    // 原方法
    Method oldMethod = class_getClassMethod([self class], @selector(systemFontOfSize:));
    // 交换类方法
    method_exchangeImplementations(newMethod, oldMethod);
}

+ (UIFont *)adjustFont:(CGFloat)fontSize {
    UIFont *newFont = nil;
    newFont = [UIFont adjustFont:fontSize * [UIScreen mainScreen].bounds.size.width / UIScreenWidth];
    return newFont;
}

@end
