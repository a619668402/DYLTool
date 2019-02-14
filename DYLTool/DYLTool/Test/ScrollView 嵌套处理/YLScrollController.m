//
//  YLScrollController.m
//  DYLTool
//
//  Created by sky on 2019/1/11.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "YLScrollController.h"
#import "YLTableController.h"

@interface YLScrollController ()<UIScrollViewDelegate, YLTableControllerDelegate>

@property (nonatomic, strong, readwrite) UIScrollView *scrollView;

@property (nonatomic, assign, readwrite) BOOL canScroll;

@property (nonatomic, strong, readwrite) UIView *topView;

@property (nonatomic, strong, readwrite) YLTableController *vc;

@end

@implementation YLScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)yl_initViews {
    self.canScroll = YES;
    self.scrollView = [UIScrollView new];
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.topView = [UIView new];
    self.topView.backgroundColor = red_color;
    [self.scrollView addSubview:self.topView];
    self.scrollView.contentSize = CGSizeMake(KScreenWidth, KScreenHeight - KSafeBottomMargin - KNavAndStatusHeight + 210);
    
    UIView *centerView = [UIView new];
    centerView.backgroundColor = green_color;
    [self.scrollView addSubview:centerView];
    
    self.vc = [[YLTableController alloc] initWithViewModel:nil];
    [self addChildViewController:self.vc];
    self.vc.delegate = self;
    [self.scrollView addSubview:self.vc.view];
    self.vc.view.frame = CGRectMake(0, 260, KScreenWidth, KScreenHeight - KNavAndStatusHeight - KSafeBottomMargin - 50);
    
    KWeakSelf(self);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view).offset(KNavAndStatusHeight);
        make.left.right.equalTo(weakself.view).offset(0);
        make.bottom.equalTo(weakself.view).offset(-KSafeBottomMargin);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakself.view).offset(0);
        make.top.equalTo(weakself.scrollView.mas_top).offset(0);
        make.height.mas_equalTo(210);
    }];
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.topView.mas_bottom).offset(0);
        make.left.right.equalTo(weakself.view).offset(0);
        make.height.mas_equalTo(50);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    KLog(@"-------%.2f", offsetY);
    if (offsetY >= 210) {
        self.canScroll = NO;
        scrollView.contentOffset = CGPointMake(0, 210);
        [self.vc makeTableControllerScroll:YES];
    } else {
        if (!self.canScroll) {
            scrollView.contentOffset = CGPointMake(0, 210);
        } else {
            
        }
    }
}

- (void)tableControllerLeaveTop {
    self.canScroll = YES;
}

- (void)setCanScroll:(BOOL)canScroll {
    _canScroll = canScroll;
    self.scrollView.showsVerticalScrollIndicator = canScroll;
}

@end
