//
//  UILabel+YLInitialize.m
//  DYLTool
//
//  Created by sky on 2018/8/22.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UILabel+YLInitialize.h"

@implementation UILabel (YLInitialize)

+ (instancetype)yl_initWithFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor textAligment:(NSTextAlignment)textAligment numberOfLines:(NSInteger)numberOfLines {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = textColor;
    label.font = font;
    label.text = text;
    label.textAlignment = textAligment;
    label.numberOfLines = numberOfLines;
    return label;
}

@end
