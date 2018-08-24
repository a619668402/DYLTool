//
//  YLTestCircleController.m
//  DYLTool
//
//  Created by sky on 2018/8/23.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLTestCircleController.h"
#import "YLCircleView.h"

@interface YLTestCircleController ()

@end

@implementation YLTestCircleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, KNavAndStatusHeight + 20, 100, 44);
    btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [btn setTitle:@"Click" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)_btnClick:(UIButton *)sender {
    YLCircleView *testView = [[YLCircleView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:testView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.2 animations:^{
            testView.alpha = 0;
        } completion:^(BOOL finished) {
            [testView removeFromSuperview];
        }];
    });
}

@end
