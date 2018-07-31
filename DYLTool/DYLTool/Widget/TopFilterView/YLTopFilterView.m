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
const CGFloat animateTime = 0.14f;

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

#pragma mark ************* Public Method Start *************
/// 更改选中按钮文字
- (void)updateClickBtnTitle:(NSString *)titleStr btnTag:(NSInteger)tag {
    UIButton *btn = [(UIButton *)self viewWithTag:tag];
    [btn setTitle:titleStr forState:UIControlStateNormal];
}
/// 重置所有按钮标题
- (void)resetBtnTitle {
    for (int i = 0; i < self.viewModel.dataSource.count; i ++) {
        UIButton *btn = [(UIButton *)self viewWithTag:i + 1];
        [btn setTitle:self.viewModel.dataSource[i] forState:UIControlStateNormal];
    }
}
#pragma mark ************* Public Method End   *************

#pragma mark ************* Private Method Start *************
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
        btn.selected = NO;
        [btn setTitleColor:self.viewModel.defaultColor forState:UIControlStateNormal];
        [btn setTitleColor:self.viewModel.selectColor forState:UIControlStateSelected];
        [btn setTitleColor:self.viewModel.selectColor forState:UIControlStateHighlighted | UIControlStateSelected];
        [btn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    // 底部分割线
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.size.height - KGlobleLineHeight, self.frame.size.width, KGlobleLineHeight)];
    bottomLineView.backgroundColor = [UIColor grayColor];
    [self addSubview:bottomLineView];
}

/// 筛选按钮点击事件
- (void)_btnClick:(UIButton *)btn {
    if (self.viewModel.viewSource.count != self.viewModel.dataSource.count) {
        KLog(@"*************数据源有误,请确认后在执行*************");
        return;
    }
    if (_tempView != nil && self.isShow && _tempBtn != btn) {
        [self _dismissViewWithOutAnimation];
    } else {
        [self _dismissView];
    }
    UIView *view = self.viewModel.viewSource[btn.tag - 1];
    [self _showView:view];
    if (_tempBtn != nil) {
        _tempBtn.selected = NO;
    }
    btn.selected = !btn.selected;
    _tempBtn = btn;
    _tempView = view;
}
/// 显示下拉筛选View
- (void)_showView:(UIView *)view {
    if (self.isShow == NO) {
        UIView *parentView = [self superview];
        [parentView addSubview:self.coverView];
        [parentView addSubview:view];
        [UIView animateWithDuration:animateTime animations:^{
            view.frame = CGRectMake(view.yl_x, view.yl_y + view.yl_height, view.yl_width, 500);
            _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        } completion:^(BOOL finished) {
            if (finished) {
                self.isShow = YES;
            }
        }];
    }
}
/// 移除下拉筛选View(带动画)
- (void)_dismissView {
    if (self.isShow == YES) {
        [UIView animateWithDuration:animateTime animations:^{
            _tempView.frame = CGRectMake(self.yl_x, self.yl_y + self.yl_height, _tempView.yl_width, 0);
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
/// 移除下拉筛选View(不带动画)
- (void)_dismissViewWithOutAnimation {
    _tempView.frame = CGRectMake(self.yl_x, self.yl_height + self.yl_y, _tempView.yl_width, 0);
    [_tempView removeFromSuperview];
    self.isShow = NO;
    self.tempBtn.selected = NO;
}

#pragma mark ************* Private Method End   *************

#pragma mark ************* Lazyload Start *************
/// 蒙版View
- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(self.yl_x, self.yl_height + self.yl_y, self.yl_width, KScreenHeight)];
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [_coverView setOpaque:NO];
        [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_dismissView)]];
    }
    return _coverView;
}
#pragma mark ************* Lazyload End   *************

@end
