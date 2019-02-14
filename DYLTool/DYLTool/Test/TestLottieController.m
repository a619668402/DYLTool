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

@property (nonatomic, strong, readwrite) UILabel *label;

@property (nonatomic, strong, readwrite) CADisplayLink *cadislpay;

@end

@implementation TestLottieController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(50, 300, 100, 50)];
    self.label.text = @"20";
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.label];
    
    self.cadislpay = [CADisplayLink displayLinkWithTarget:self selector:@selector(_refreshLabel)];
    [self.cadislpay addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    self.cadislpay.frameInterval = 1;
    
}

- (void)_refreshLabel {
    NSInteger currentNUmber = self.label.text.integerValue;
    self.label.text = [NSString stringWithFormat:@"%ld", ++currentNUmber];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect lottieRect = CGRectMake(0, KNavAndStatusHeight, 100, 100);
    self.lottieLogo.frame = lottieRect;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.lottieLogo play];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.lottieLogo pause];
    [self.cadislpay invalidate];
    self.cadislpay = nil;
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
