//
//  BaseControllerProtocol.h
//  Base
//
//  Created by sky on 2018/6/21.
//  Copyright © 2018年 DYL. All rights reserved.
//  BaseViewControllerProtocol

#import <Foundation/Foundation.h>

@protocol BaseControllerProtocol <NSObject>

@required

/**
 初始化子控件
 */
- (void)yl_initViews;

/**
 初始化默认值
 */
- (void)yl_initValues;

@optional

@end
