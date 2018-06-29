//
//  BaseNavController.h
//  DYLTool
//
//  Created by sky on 2018/6/28.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
                导航控制器根类
 *********************************************/

#import <UIKit/UIKit.h>

@interface BaseNavController : UINavigationController

/// 显示导航栏的细线
- (void)showNavigationBottomLine;
/// 隐藏导航栏的细线
- (void)hideNavigationBottomLine;

@end
