//
//  BaseTabBar.m
//  Base
//
//  Created by sky on 2018/6/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseTabBar.h"

@interface BaseTabBar()

@property (nonatomic, readwrite, weak) UIView *divider;

@end

@implementation BaseTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 去掉 tabBar 分割线以及背景图片
        [self setShadowImage:[UIImage new]];
//        [self setBackgroundImage:[UIImage ]]
    }
    return self;
}

@end
