//
//  UIBarButtonItem+Extension.h
//  DYLTool
//
//  Created by sky on 2018/6/26.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
            快速创建BarButton
 *********************************************/
#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 通过系统方法初始化一个 UIBarButtonItem

 @param title 显示文字 eg:完成 取消
 @param color 文字颜色 if nil ，The Color is [UIColor whiteColor]
 @param imgName 图片名称
 @param target target
 @param selector selector
 @param textType 是否是纯文字
 @return init a UIBarButtonItem
 */
+ (UIBarButtonItem *)yl_systemItemWithTitle:(NSString *)title
                                 titleColor:(UIColor *)color
                                  imageName:(NSString *)imgName
                                     target:(id)target
                                   selector:(SEL)selector
                                   textType:(BOOL)textType;

/**
 通过自定义方法,快速初始化一个 UIBarButtonItem, 内部是按钮

 @param title 显示文字 eg:完成 取消
 @param titleColor 文字颜色
 @param imageName 图片名称
 @param target target
 @param selector selector
 @param contentHorizontalAlignment 文本对齐方向
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)yl_customeItemWithTitle:(NSString *)title
                                  titleColor:(UIColor *)titleColor
                                   imageName:(NSString *)imageName
                                      target:(id)target
                                    selector:(SEL)selector
                   contentHorizontalAligment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment;

/**
 快速创建一个导航栏 leftBarButtonItem 用于返回(pop) 或者 dismiss 只能是纯图片

 @param title title
 @param imageName 返回按钮图片名称
 @param target target
 @param action action
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)yl_backItemWithTitle:(NSString *)title
                                imageName:(NSString *)imageName
                                   target:(id)target
                                   action:(SEL)action;


/**
 快速创建一个导航栏 leftBarButtonItem 用于返回(pop) 或者 dismiss 只能是纯图片

 @param imageName 返回按钮图片名称
 @param target target
 @param action action
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)yl_backItemWithImage:(NSString *)imageName
                                   target:(id)target
                                   action:(SEL)action;

@end
