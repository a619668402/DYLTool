//
//  BaseViewController.h
//  Base
//
//  Created by sky on 2018/6/11.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
            顶级 ViewController
 *********************************************/
#import <UIKit/UIKit.h>
#import "BaseControllerProtocol.h"
#import "YLProgressHUD.h"
#import "BaseViewModel.h"

@interface BaseViewController : UIViewController<BaseControllerProtocol, UINavigationControllerDelegate>

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
 the 'viewModel' parameter in '-initWithViewModel:' method
 */
@property (nonatomic, readonly, strong) BaseViewModel *viewModel;

/**
 截图 (Push/Pop Present/Dismiss 过度过程中的缩略图)
 */
@property (nonatomic, readwrite, strong) UIView *snapshot;

/**
 定义初始化方法

 @param viewModel 对应的ViewModel
 */
- (instancetype)initWithViewModel:(BaseViewModel *)viewModel;

/**
 绑定数据模型
 */
- (void)bindViewModel;

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
 网络请求错误处理

 @param error 错误信息
 */
- (void)ProcessRequestError:(NSError *)error;

@end
