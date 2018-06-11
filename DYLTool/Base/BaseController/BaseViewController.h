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

/**
 接收获取到的参数
 */
@property (nonatomic, copy, readonly) NSDictionary *parameter;

/**
 定义初始化方法

 @param parameter 传递的参数,没有传nil;
 */
- (void)initWithParameter:(NSDictionary *)parameter;

/**
 显示加载动画
 */
- (void)showIndicatorView;

/**
 移除加载动画
 */
- (void)dismissIndicatorView;


@end
