//
//  UIViewController+YLNavConfig.h
//  DYLTool
//
//  Created by sky on 2018/8/17.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
                导航栏设置
 *********************************************/
#import <UIKit/UIKit.h>

@interface UIViewController (YLNavConfig)

@property (nonatomic, assign) UIBarStyle yl_barStyle;

@property (nonatomic, strong) UIColor *yl_barTintColor;

@property (nonatomic, strong) UIImage *yl_barImage;

@property (nonatomic, strong) UIColor *yl_tintColor;

@property (nonatomic, copy) NSDictionary *yl_titleTextAttributes;

@property (nonatomic, assign) CGFloat yl_barAlpha;

@property (nonatomic, assign) BOOL yl_barHidden;

@property (nonatomic, assign) BOOL yl_barShadowHidden;

@property (nonatomic, assign) BOOL yl_backInteractive;

@property (nonatomic, assign) BOOL yl_swipeBackEnabled;

@property (nonatomic, assign, readonly) CGFloat yl_computedBarShadowAlpha;

@property (nonatomic, strong, readonly) UIColor *yl_computedBarTintColor;

@property (nonatomic, strong, readonly) UIImage *yl_computedBarImage;

- (void)yl_setNeedsUpdateNavigationBar;

- (void)yl_setNeedsUpdateNavigationBarAlpha;

- (void)yl_setNeedsUpdateNavigationBarColorOrImage;

- (void)yl_setNeedsUpdateNavigationBarShadowAlpha;

@end
