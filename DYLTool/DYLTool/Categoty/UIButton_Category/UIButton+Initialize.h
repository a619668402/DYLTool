//
//  UIButton+Initialize.h
//  DYLTool
//
//  Created by sky on 2018/8/2.
//  Copyright © 2018年 DYL. All rights reserved.
//

/*********************************************
            UIButton 快速初始化
 *********************************************/
#import <UIKit/UIKit.h>

@interface UIButton (Initialize)


/**
 快读实例化一个UIButton对象

 @param frame frame
 @param type type
 @param btnTitle btn 标题
 @param color 背景颜色
 @param target 调用对象
 @param action 方法
 @return UIButton 实例
 */
+ (instancetype)yl_initWithFrame:(CGRect)frame
                      buttonType:(UIButtonType)type
                           title:(NSString *)btnTitle
                 backgroundColor:(UIColor *)color
                          target:(id)target
                        selector:(SEL)action;

@end
