//
//  NSAttributedString+Ext.h
//  DYLTool
//
//  Created by sky on 2018/7/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Ext)

/// 计算富文本高度(系统计算的不准确)
- (CGFloat)heightWithContainWidth:(CGFloat)width;

@end
