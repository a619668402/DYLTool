//
//  ViewController.m
//  DYLTool
//
//  Created by sky on 2018/5/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "ViewController.h"
#import "MacrosHeader.h"
#import "TestSearchController.h"

@interface ViewController ()

@property (nonatomic, strong) UISearchBar *mBar;

@property (nonatomic, strong) UIButton *mBtn;

@property (nonatomic, strong) RACCommand *mBtnCommand;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initViews {
    [self.view addSubview:self.mBar];
    [self.view addSubview:self.mBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)yl_initValues {
    _mBtnCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        TestSearchController *vc = [[TestSearchController alloc] initWithViewModel:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return [RACSignal empty];
    }];
}

- (UISearchBar *)mBar {
    if (!_mBar) {
        _mBar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 60, KScreenWidth - 30, 44)];
        _mBar.barStyle = UIBarStyleDefault;
        _mBar.placeholder = @"请输入搜索内容";
    }
    return _mBar;
}

- (UIButton *)mBtn {
    if (!_mBtn) {
        _mBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _mBtn.backgroundColor = red_color;
        _mBtn.frame = CGRectMake((KScreenWidth - 60) / 2, 120, 60, 44);
        _mBtn.rac_command = _mBtnCommand;
    }
    return _mBtn;
}

@end
