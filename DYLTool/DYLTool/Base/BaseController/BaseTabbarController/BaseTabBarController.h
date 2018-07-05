//
//  BaseTabBarController.h
//  Base
//
//  Created by sky on 2018/6/25.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
            自定义 TabBarController
 *********************************************/
#import "BaseViewController.h"

@interface BaseTabBarController : BaseViewController<UITabBarDelegate>

/// The 'tabBarController' instance
@property (nonatomic, readonly, strong) UITabBarController *tabBarController;

@end
