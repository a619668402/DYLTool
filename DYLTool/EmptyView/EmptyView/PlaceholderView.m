//
//  DYLEmptyView.m
//  EmptyView
//
//  Created by sky on 2018/5/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "PlaceholderView.h"

@implementation PlaceholderView

/**
 *  构造方法
 *  @param frame 占位图frame
 *  @param type  占位图类型
 *  @param delegate 占位图代理方
 *  return 指定frame,类型和代理方法的占位图
 */
- (instancetype)initWithFrame:(CGRect)frame type:(PlaceholderViewType)type delegate:(id)delegate {
    if (self = [super initWithFrame:frame]) {
        _type = type;
        _delegate = delegate;
        [self setUpUI]
    }
    return self;
}

#pragma mark ---- UI 搭建 ----
/** UI搭建 */
- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [UIImageView alloc] initWithFrame:CGRectZero;
    [self addSubview:imageView];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:descLabel];
    
    UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadBtn.frame = CGRectZero;
    [reloadBtn addTarget:self action:@selector(reloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reloadBtn];
    
}
#pragma mark ---- 重新加载按钮点击事件 ----
/** 重新加载按钮点击事件 */
- (void)reloadButtonClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(placeholderView:reloadButtonDidClick:)]) {
        [_delegate placehoderview:self reloadButtonDidClick:sender];
    }
    [self removeFromSuperview];
}

@end
