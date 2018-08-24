//
//  YLCircleView.h
//  DYLTool
//
//  Created by sky on 2018/8/23.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLCircleView : UIView

/// 底层圆环颜色, default is whiteColor
@property (nonatomic, strong, readwrite) UIColor *bottomShapeLayerColor;
/// 上层弧线颜色, default is redColor
@property (nonatomic, strong, readwrite) UIColor *topShareLayerColor;
/// 背景View, container View of circle, default is grayColor
@property (nonatomic, strong, readwrite) UIColor *bgViewColor;
/// 圆弧弧线宽度, default is 3.0f
@property (nonatomic, assign, readwrite) CGFloat circleBorderWidth;
/// 圆半径, default is 45.0f;
@property (nonatomic, assign, readwrite) CGFloat circleWidth;

@end
