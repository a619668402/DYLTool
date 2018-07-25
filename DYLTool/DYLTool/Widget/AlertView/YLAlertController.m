//
//  YLAlertController.m
//  DYLTool
//
//  Created by sky on 2018/7/20.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLAlertController.h"

@interface YLAlertController ()

@end

@implementation YLAlertController

+ (instancetype)alertWithViewController {
    YLAlertController *alertController = [[YLAlertController alloc] init];
    alertController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    return alertController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initValues];
    [self _initViews];
}

#pragma mark ************* Private Method Start *************
- (void)_initValues {
    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.5f];
}

- (void)_initViews {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.bounds = CGRectMake(0, 0, 100, 30);
    btn.center = self.view.center;
    [self.view addSubview:btn];
}
#pragma mark ************* Private Method End   *************

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
