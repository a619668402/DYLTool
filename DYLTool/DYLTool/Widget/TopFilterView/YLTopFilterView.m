//
//  YLTopFilterView.m
//  DYLTool
//
//  Created by sky on 2018/7/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLTopFilterView.h"

@interface YLTopFilterView ()
/// 记录点击的Button
@property (nonatomic, strong) UIButton *tempBtn;
/// 记录展示的View
@property (nonatomic, strong) UIView *tempView;
/// 蒙版View
@property (nonatomic, strong) UIView *coverView;
/// 判断View是否正在展示
@property (nonatomic, assign) BOOL isShow;

@end
/// 动画时间
const CGFloat animateTime = 0.10f;

@implementation YLTopFilterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame viewModel:(YLTopFilterViewModel *)viewModel {
    if (self = [super initWithFrame:frame]) {
        self.viewModel = viewModel;
        [self _initViews];
        [self _initValues];
    }
    return self;
}

- (void)_initValues {
    self.isShow = NO;
}

- (void)_initViews {
    for (int i = 0; i < self.viewModel.dataSource.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i + 1;
        btn.frame = CGRectMake((self.frame.size.width / self.viewModel.dataSource.count) * i, 0, self.frame.size.width / self.viewModel.dataSource.count, self.frame.size.height - 0.5f);
        [btn setTitle:self.viewModel.dataSource[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:self.viewModel.fontSize];
        [btn setTitleColor:self.viewModel.defaultColor forState:UIControlStateNormal];
        [btn setTitleColor:self.viewModel.selectColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.selected = NO;
        [self addSubview:btn];
    }
    // 底部分割线
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.size.height - KGlobleLineHeight, self.frame.size.width, KGlobleLineHeight)];
    bottomLineView.backgroundColor = [UIColor grayColor];
    [self addSubview:bottomLineView];
}

#pragma mark ************* Private Method Start *************
- (void)_btnClick:(UIButton *)btn {
    if (self.viewModel.viewSource.count != self.viewModel.dataSource.count) {
        KLog(@"*************数据源有误,请确认后在执行*************");
        return;
    }
    if (_tempView != nil && self.isShow) {
        [self _dismissView];
    }
    UIView *view = self.viewModel.viewSource[btn.tag - 1];
    // 1. 先判断是否点击的是同一个按钮
    if (_tempBtn == btn) {
    }
    if (_tempBtn != nil) {
        _tempBtn.selected = NO;
    }
    btn.selected = !btn.selected;
    [self _showView:view];
    _tempBtn = btn;
    _tempView = view;
}

- (void)_showView:(UIView *)view {
    if (self.isShow == NO) {
        UIView *parentView = [self superview];
        [parentView addSubview:self.coverView];
        [parentView addSubview:view];
        [UIView animateWithDuration:animateTime animations:^{
            view.frame = CGRectMake(view.yl_left, view.yl_bottom, view.yl_width, 300);
            _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        } completion:^(BOOL finished) {
            if (finished) {
                self.isShow = YES;
            }
        }];
    }
}

- (void)_dismissView {
    if (self.isShow == YES) {
        [UIView animateWithDuration:animateTime animations:^{
            _tempView.frame = CGRectMake(self.yl_left, self.yl_bottom, _tempView.yl_width, 0);
            _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        } completion:^(BOOL finished) {
            if (finished) {
                [_tempView removeFromSuperview];
                [_coverView removeFromSuperview];
                self.isShow = NO;
                self.tempBtn.selected = NO;
            }
        }];
    }
}

#pragma mark ************* Private Method End   *************

#pragma mark ************* Lazyload Start *************
- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(self.yl_left, self.yl_bottom, self.yl_width, KScreenHeight)];
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [_coverView setOpaque:NO];
        [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_dismissView)]];
    }
    return _coverView;
}
#pragma mark ************* Lazyload End   *************

@end
