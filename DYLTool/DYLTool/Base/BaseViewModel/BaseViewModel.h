//
//  BaseViewModel.h
//  DYLTool
//
//  Created by sky on 2018/6/27.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
            所有自定义视图模型基类
 *********************************************/
#import <Foundation/Foundation.h>

@protocol BaseViewModelServices;

@interface BaseViewModel : NSObject

/**
 the 'params' parameter in '-initWithParams:' method
 */
@property (nonatomic, readonly, copy) NSDictionary *params;
/**
 the 'services' parameter in '-initWithParameter:services:' method
 */
@property (nonatomic, readonly, strong) id<BaseViewModelServices> services;

/**
 navItem title
 */
@property (nonatomic, readwrite, copy) NSString *navTitle;

/**
 返回按钮 title, default is nil (暂时无效,没有做处理,如果设置标题,返回按钮距离左侧间距过大)
 如果设置该值, 当 push 到一个新的 controller ,则 controller 左侧返回按钮的 title 为backTitle
 */
@property (nonatomic, readwrite, copy) NSString *backTitle;

/**
 IQKeyboardManager 是否让 IQKeyboardManager 管理键盘的事件 默认是YES(键盘管理)
 */
@property (nonatomic, readwrite, assign) BOOL keyBoardEnable;

/**
 FDFullscreenPopGesture
 Whether the interactive pop gesture is disabled when contained in a navigation
 stack (是否取消左滑pop到上一层的功能(栈底控制器无效), 默认为 NO, 不取消)
 */
@property (nonatomic, readwrite, assign) BOOL interactivePopDisabled;

/**
 should fetch local data when viewModel init. default is YES
 */
@property (nonatomic, readwrite, assign) BOOL shouldFetchLocalDataOnViewModelInitliaze;

/**
 是否需要在 viewDidLoad 中获取数据, default is YES
 BaseTableController 如果开启下拉刷新,此选项要关闭,否则会导致进入页面时重复获取数据
 */
@property (nonatomic, assign, readwrite) BOOL shouldRequestRemoteDataOnViewDidLoad;

/**
 是否键盘弹起的时候,点击其他区域隐藏 默认YES
 */
@property (nonatomic, readwrite, assign) BOOL shouldResignOnTouchOutside;

/**
 是否隐藏该控制器的导航栏, 默认不隐藏(NO)
 */
@property (nonatomic, readwrite, assign) BOOL prefersNavigationBarHidden;

/**
 是否隐藏该控制器的导航栏底部的分割线, 默认不隐藏(NO)
 */
@property (nonatomic, readwrite, assign) BOOL prefersNavigationBarBottomLineHidden;

/**
 config Keyboard distance from textfield, can't be less than zero. default is 10.0f
 */
@property (nonatomic, readwrite, assign) CGFloat keyboardDistanceFromTextField;

- (instancetype)initWithParams:(NSDictionary *)params services:(id<BaseViewModelServices>)services;

/**
 An additional method, in which you can initialize data.
 
 This method will be execute after the execution of '-initWithParams:' method.
 */
- (void)initialize;

@end
