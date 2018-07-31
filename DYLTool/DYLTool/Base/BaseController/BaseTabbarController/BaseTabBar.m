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
        [self setBackgroundImage:[UIImage yl_resizableImage:@"tabbarBkg_5x49@2x.png"]];
        
        // 添加细线(Tabbar 顶部)
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = rgb(167.0f, 167.0f, 170.0f);
        [self addSubview:divider];
        self.divider = divider;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self bringSubviewToFront:self.divider];
    self.divider.yl_height = 0.5f;
    self.divider.yl_width = KScreenWidth;
}

@end
