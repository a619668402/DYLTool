//
//  BaseViewController.h
//  Base
//
//  Created by sky on 2018/6/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController

- (instancetype)init DEPRECATED_MSG_ATTRIBUTE("use initWithParameter: instead");

/**
 接收获取到的参数
 */
@property (nonatomic, copy, readonly) NSDictionary *parameter;

/**
 加载动画文字描述
 */
@property (nonatomic, copy) NSString *lodingMessage;

/**
 定义初始化方法

 @param parameter 传递的参数,没有传nil;
 */
- (instancetype)initWithParameter:(NSDictionary *)parameter;

/**
 显示加载动画
 */
- (void)showIndicatorView;

/**
 带文字描述的加载动画

 @param message 描述文字
 */
- (void)showIndicatorViewWithMessage:(NSString *)message;

/**
 移除加载动画
 */
- (void)dismissIndicatorView;

/**
 赋默认值
 */
- (void)initValue;

/**
 初始化控件
 */
- (void)initView;

@end
