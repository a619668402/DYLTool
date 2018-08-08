//
//  TestScrollController.m
//  DYLTool
//
//  Created by sky on 2018/8/7.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestScrollController.h"

@interface TestScrollController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *topScrollView;

@property (nonatomic, strong) UIScrollView *bottomScrollView;

@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation TestScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)yl_initValues {
    [super yl_initValues];
}

- (void)yl_initViews {
    [super yl_initViews];
    [self.view addSubview:self.topScrollView];
    [self.view addSubview:self.bottomScrollView];
}

- (void)_btnClick:(UIButton *)btn {
    [self _setSelectIndex:btn.tag - 1];
    [self.bottomScrollView setContentOffset:CGPointMake((btn.tag - 1) * KScreenWidth, 0) animated:YES];
}

- (void)_setSelectIndex:(NSInteger)index {
    [self.titleArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.selected = NO;
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    }];
    UIButton *btn = (UIButton *)[self.titleArray objectAtIndex:index];
    btn.selected = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    // 设置标题居中
    [self _setTitleBtnCenter:btn];
}

- (void)_setTitleBtnCenter:(UIButton *)btn {
    CGFloat offsetX = btn.center.x - KScreenWidth / 2;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.topScrollView.contentSize.width - KScreenWidth;
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.topScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"第一个", @"第二个", @"第三个", @"第四个", @"第五个", @"第六个", @"第七个", @"第八个", @"第九个", @"10", @"11", @"12", @"13", @"145", @"15", @"16", @"17"];
    }
    return _dataSource;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithCapacity:self.dataSource.count];
    }
    return _titleArray;
}

- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KNavAndStatusHeight, KScreenWidth, 50)];
        float tempX = 10;
        for (int i = 0; i < self.dataSource.count; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            float tempWidth = [self.dataSource[i] yl_widthWithFontSize:14.f height:_topScrollView.yl_height] + 10;
            btn.frame = CGRectMake(tempX, 0, tempWidth, 50);
            btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn setTitle:self.dataSource[i] forState:UIControlStateNormal];
            btn.selected = NO;
            btn.tag = i + 1;
            [btn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
            tempX += tempWidth + 10;
            [_topScrollView addSubview:btn];
            [self.titleArray addObject:btn];
            if (i == 0) {
                btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
                btn.selected = YES;
            }
        }
        _topScrollView.contentSize = CGSizeMake(tempX, 50);
        _topScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _topScrollView;
}

- (UIScrollView *)bottomScrollView {
    if (!_bottomScrollView) {
        _bottomScrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KNavAndStatusHeight + self.topScrollView.yl_height, KScreenWidth, KScreenHeight - KNavAndStatusHeight - self.topScrollView.yl_height)];
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.contentSize = CGSizeMake(KScreenWidth * self.dataSource.count, KScreenHeight - KNavAndStatusHeight - self.topScrollView.yl_height);
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.delegate = self;
        for (int i = 0; i < self.dataSource.count; i ++) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(i * KScreenWidth, 0, _bottomScrollView.yl_width, _bottomScrollView.yl_height)];
            lab.text = self.dataSource[i];
            lab.font = [UIFont systemFontOfSize:25.f];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = blue_color;
            [_bottomScrollView addSubview:lab];
        }
    }
    return _bottomScrollView;
}

#pragma mark ************* UIScrollView Delegate Start *************

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat offsetX = targetContentOffset->x;
    NSInteger pagNum = offsetX / KScreenWidth;
    [self _setSelectIndex:pagNum];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}

#pragma mark ************* UIScrollView Delegate End   *************

@end
