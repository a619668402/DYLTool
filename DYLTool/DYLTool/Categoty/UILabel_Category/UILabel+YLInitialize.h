//
//  UILabel+YLInitialize.h
//  DYLTool
//
//  Created by sky on 2018/8/22.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
             UILabel 快速初始化
 *********************************************/
#import <UIKit/UIKit.h>

@interface UILabel (YLInitialize)

+ (instancetype)yl_initWithFrame:(CGRect)frame
                            font:(UIFont *)font
                            text:(NSString *)text
                       textColor:(UIColor *)textColor
                    textAligment:(NSTextAlignment)textAligment
                   numberOfLines:(NSInteger)numberOfLines;

@end