//
//  TestSearchController_1.m
//  DYLTool
//
//  Created by sky on 2018/7/4.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestSearchController_1.h"
#import "MacrosHeader.h"

@interface TestSearchController_1 ()

@property (nonatomic, strong) UIView *customerNav;

@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation TestSearchController_1

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)yl_initViews {
    [super yl_initViews];
    [self.view addSubview:self.customerNav];
    [self.customerNav addSubview:self.backBtn];
}

- (void)yl_initValues {
    [super yl_initValues];
}
//
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 判断要显示的控制器是自己
//    BOOL isSelf = [viewController isKindOfClass:[self class]];
//    if (isSelf) {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    } else {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)customerNav {
    if (!_customerNav) {
        _customerNav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];
        _customerNav.backgroundColor = [UIColor greenColor];
    }
    return _customerNav;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _backBtn.frame = CGRectMake(0, 20, 60, 44);
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        _backBtn.titleLabel.textColor = [UIColor whiteColor];
        [_backBtn setImage:[UIImage imageNamed:@"img_back"] forState:UIControlStateNormal];
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _backBtn;
}

@end
