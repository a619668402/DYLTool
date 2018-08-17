//
//  UIViewController+YLNavConfig.m
//  DYLTool
//
//  Created by sky on 2018/8/17.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIViewController+YLNavConfig.h"
#import <objc/runtime.h>

@implementation UIViewController (YLNavConfig)

- (UIBarStyle)yl_barStyle {
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return [obj integerValue];
    }
    return [UINavigationBar appearance].barStyle;
}

- (void)setYl_barStyle:(UIBarStyle)yl_barStyle {
    objc_setAssociatedObject(self, @selector(yl_barStyle), @(yl_barStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)yl_barTintColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYl_barTintColor:(UIColor *)yl_barTintColor {
    objc_setAssociatedObject(self, @selector(yl_barTintColor), yl_barTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)yl_barImage {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYl_barImage:(UIImage *)yl_barImage {
    objc_setAssociatedObject(self, @selector(yl_barImage), yl_barImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)yl_tintColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYl_tintColor:(UIColor *)yl_tintColor {
    objc_setAssociatedObject(self, @selector(yl_tintColor), yl_tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)yl_titleTextAttributes {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ?: [UINavigationBar appearance].titleTextAttributes;
}

- (void)setYl_titleTextAttributes:(NSDictionary *)yl_titleTextAttributes {
    objc_setAssociatedObject(self, @selector(setYl_titleTextAttributes:), yl_titleTextAttributes, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)yl_barAlpha {
    id obj = objc_getAssociatedObject(self, _cmd);
    if (self.yl_barHidden) {
        return 0;
    }
    return obj ? [obj floatValue] : 1.f;
}

- (void)setYl_barAlpha:(CGFloat)yl_barAlpha {
    objc_setAssociatedObject(self, @selector(yl_barAlpha), @(yl_barAlpha), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)yl_barHidden {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : NO;
}

- (void)setYl_barHidden:(BOOL)yl_barHidden {
    if (yl_barHidden) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        self.navigationItem.titleView = [UIView new];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.titleView = nil;
    }
}

- (BOOL)yl_barShadowHidden {
    id obj = objc_getAssociatedObject(self, _cmd);
    return self.yl_barHidden || obj ? [obj boolValue] : NO;
}

- (void)setYl_barShadowHidden:(BOOL)yl_barShadowHidden {
    objc_setAssociatedObject(self, @selector(yl_barShadowHidden), @(yl_barShadowHidden), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)yl_backInteractive {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : YES;
}

- (void)setYl_backInteractive:(BOOL)yl_backInteractive {
    objc_setAssociatedObject(self, @selector(yl_backInteractive), @(yl_backInteractive), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)yl_swipeBackEnabled {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : YES;
}

- (void)setYl_swipeBackEnabled:(BOOL)yl_swipeBackEnabled {
    objc_setAssociatedObject(self, @selector(yl_swipeBackEnabled), @(yl_swipeBackEnabled), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)yl_computedBarShadowAlpha {
    return self.yl_barShadowHidden ? 0 : self.yl_barAlpha;
}

- (UIColor *)yl_computedBarTintColor {
    if (self.yl_barImage) {
        return nil;
    }
    UIColor *color = [self yl_barTintColor];
    if (!color) {
        if ([[UINavigationBar appearance] backgroundImageForBarMetrics:UIBarMetricsDefault]) {
            return nil;
        }
        if ([UINavigationBar appearance].barTintColor) {
            color = [UINavigationBar appearance].barTintColor;
        } else {
            color = [UINavigationBar appearance].barStyle == UIBarStyleDefault ? [UIColor colorWithRed:247 / 255.0f green:247 / 255.f blue:247 / 255.f alpha:.8f] : [UIColor colorWithRed:28 / 255.f green:28 / 255.f blue:28 / 255.f alpha:0.729];
        }
    }
    return color;
}

- (void)yl_setNeedsUpdateNavigationBar {
    if (self.navigationController && [self.navigationController isKindOfClass:[BaseNavController class]]) {
        BaseNavController *nav = (BaseNavController *)self.navigationController;
    }
}

@end
