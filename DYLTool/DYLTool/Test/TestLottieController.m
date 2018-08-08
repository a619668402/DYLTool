//
//  TestLottieController.m
//  DYLTool
//
//  Created by sky on 2018/8/6.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestLottieController.h"
#import <lottie-ios/Lottie/Lottie.h>

@interface TestLottieController ()

@property (nonatomic, strong) LOTAnimationView *lottieLogo;

@end

@implementation TestLottieController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect lottieRect = CGRectMake(0, KNavAndStatusHeight, KScreenWidth, KScreenWidth);
    self.lottieLogo.frame = lottieRect;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.lottieLogo play];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.lottieLogo pause];
}

- (void)yl_initValues {
    [super yl_initValues];
}

- (void)yl_initViews {
    [super yl_initViews];
    [self.view addSubview:self.lottieLogo];
}

- (LOTAnimationView *)lottieLogo {
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"laugh"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
    }
    return _lottieLogo;
}

@end
