//
//  UILabel+LineSpaceAndWordSpace.h
//  DYLTool
//
//  Created by sky on 2018/7/19.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
            设置Label字间距和行间距
 *********************************************/
#import <UIKit/UIKit.h>

@interface UILabel (LineSpaceAndWordSpace)
/// 字间距
@property (nonatomic, assign) CGFloat characterSpace;

/// 行间距
@property (nonatomic, assign) CGFloat lineSpace;

/// 关键字
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, strong) UIFont *keywordsFont;
@property (nonatomic, strong) UIColor *keywordsColor;

/// 下划线
@property (nonatomic, copy) NSString *underlineStr;
@property (nonatomic, strong) UIColor *underlineColor;

/// 计算 label 高度
/// @param maxWidth 最大宽度
/// @return lable Rect
- (CGSize)yl_getLabelRectWithMaxWidth:(CGFloat)maxWidth;
@end
