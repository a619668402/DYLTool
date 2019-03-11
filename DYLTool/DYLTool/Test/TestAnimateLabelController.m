//
//  TestAnimateLabelController.m
//  DYLTool
//
//  Created by sky on 2019/2/25.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "TestAnimateLabelController.h"
#import "AnimateView.h"

@implementation TestAnimateLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initViews {
    [super yl_initViews];
    AnimateView *v = [[AnimateView alloc] init];
    v.center = self.view.center;
    v.bounds = CGRectMake(0, 0, 100, 30);
    [self.view addSubview:v];
    [v scaleAnimate];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AnimateView *v1 = [[AnimateView alloc] init];
        v1.center = self.view.center;
        v1.bounds = CGRectMake(0, 0, 100, 30);
        [self.view addSubview:v1];
        [v1 scaleAnimate];
    });
    
}

- (void)yl_initValues {
    [super yl_initValues];
}
@end
