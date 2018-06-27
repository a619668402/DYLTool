//
//  BaseViewModel.h
//  DYLTool
//
//  Created by sky on 2018/6/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface BaseViewModel : NSObject

/**
 the 'params' parameter in '-initWithParams:' method
 */
@property (nonatomic, readonly, copy) NSDictionary *params;

/**
 navItem title
 */
@property (nonatomic, readonly, copy) NSString *navTitle;

/**
 返回按钮 title, default is nil
 如果设置该值, 当 push 到一个新的 controller ,则 controller 左侧返回按钮的 title 为backTitle
 */
@property (nonatomic, readwrite, copy) NSString *backTitle;

/**
 IQKeyboardManager 是否让 IQKeyboardManager 管理键盘的事件 默认是YES(键盘管理)
 */
@property (nonatomic, readwrite, assign) BOOL keyBoardEnable;

/**
 是否键盘弹起的时候,点击其他区域隐藏 默认YES
 */
@property (nonatomic, readwrite, assign) BOOL shouldResignOnTouchOutside;

/**
 config Keyboard distance from textfield, can't be less than zero. default is 10.0f
 */
@property (nonatomic, readwrite, assign) CGFloat keyboardDistanceFromTextField;

- (instancetype)initWithParams:(NSDictionary *)params;

/**
 An additional method, in which you can initialize data.
 
 This method will be execute after the execution of '-initWithParams:' method.
 */
- (void)initialize;

@end
