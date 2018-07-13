//
//  UIBarButtonItem+Extension.m
//  DYLTool
//
//  Created by sky on 2018/6/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIImage+Tool.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)yl_systemItemWithTitle:(NSString *)title titleColor:(UIColor *)color imageName:(NSString *)imgName target:(id)target selector:(SEL)selector textType:(BOOL)textType {
    UIBarButtonItem *item = textType ? ({
        item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:selector];
        color = color ? color : [UIColor whiteColor];
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = color;
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16.0f];
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset = CGSizeZero;
        textAttrs[NSShadowAttributeName] = shadow;
        [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        // 设置高亮状态的文字属性
        NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        highTextAttrs[NSForegroundColorAttributeName] = [color colorWithAlphaComponent:0.5f];
        [item setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
        // 设置不可用状态的文字属性
        NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        disableTextAttrs[NSForegroundColorAttributeName] = [color colorWithAlphaComponent:0.5f];
        [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
        item;
    }) : ({
        item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:selector];
        item;
    });
    return item;
}

+ (UIBarButtonItem *)yl_customeItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName target:(id)target selector:(SEL)selector contentHorizontalAligment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment {
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    titleColor = titleColor ? titleColor : [UIColor whiteColor];
    [item setTitle:title forState:UIControlStateNormal];
    [item setImage:[UIImage yl_imageAlwaysShowOriginalImageWithImageName:imageName] forState:UIControlStateNormal];
    [item.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [item setTitleColor:titleColor forState:UIControlStateNormal];
    [item setTitleColor:[titleColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
    [item setTitleColor:[titleColor colorWithAlphaComponent:0.5f] forState:UIControlStateDisabled];
    [item sizeToFit];
    item.contentHorizontalAlignment = contentHorizontalAlignment;
    [item addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}

+ (UIBarButtonItem *)yl_backItemWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action {
    return [self yl_customeItemWithTitle:title titleColor:nil imageName:imageName target:target selector:action contentHorizontalAligment:UIControlContentHorizontalAlignmentLeft];
}

+ (UIBarButtonItem *)yl_backItemWithImage:(NSString *)imageName target:(id)target action:(SEL)action {
    UIImage *image = [UIImage imageNamed:@"barbuttonicon_back_15x30"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:target action:action];
    [backItem setImageInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    return backItem;
}
@end
