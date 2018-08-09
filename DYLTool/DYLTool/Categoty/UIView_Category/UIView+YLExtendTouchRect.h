//
//  UIView+YLExtendTouchRect.h
//  DYLTool
//
//  Created by sky on 2018/8/9.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YLExtendTouchRect)

/// 设置响应范围
/// UIEdgeInsetsMake(20, 20, 20, 20)
/// 正数表示缩小范围, 负数表示扩大范围
@property (nonatomic, assign) UIEdgeInsets touchExtendInset;

@end
