//
//  BaseTabBarController.m
//  Base
//
//  Created by sky on 2018/6/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@property (nonatomic, strong, readwrite) UITabBarController *tabBarController;

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController = [[UITabBarController alloc] init];
    // 添加自控制器
    [self.view addSubview:self.tabBarController.view];
    [self addChildViewController:self.tabBarController];
    [self.tabBarController didMoveToParentViewController:self];
    
    // KVC 替换系统 tabBar
    
    
}

@end
