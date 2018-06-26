//
//  UIButton+CountDown.h
//  DYLTool
//
//  Created by sky on 2018/6/20.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CountDown)

/**
 倒计时

 @param totalTime 总时间
 @param title 倒计时结束后按钮标题
 @param countDownTitle 倒计时进行中标题
 @param mainColor 倒计时结束后按钮背景颜色
 @param countDownColor 倒计时进行中按钮背景颜色
 */
- (void)yl_countDownWithTotalTime:(NSInteger)totalTime title:(NSString *)title countDownTitle:(NSString *)countDownTitle mainColor:(UIColor *)mainColor countDownColor:(UIColor *)countDownColor;

@end
