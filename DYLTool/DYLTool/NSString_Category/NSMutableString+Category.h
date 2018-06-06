//
//  NSMutableString+Category.h
//  DYLTool
//
//  Created by sky on 2018/5/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableString (Category)

/**
 由于系统计算富文本的高度不正确，自己写了方法

 @param width <#width description#>
 @return <#return value description#>
 */
- (CGFloat)heightWithContainWidth:(CGFloat)width;

@end
