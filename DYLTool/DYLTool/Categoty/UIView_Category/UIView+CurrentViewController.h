//
//  UIView+CurrentViewController.h
//  DYLTool
//
//  Created by sky on 2018/6/8.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CurrentViewController)


/**
 获取当前View的控制器对象

 @return View所在的控制器
 */
- (UIViewController *)yl_getCurrentViewController;

@end
