//
//  TestChangeNavController.m
//  DYLTool
//
//  Created by sky on 2018/9/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestChangeNavController.h"
#import "TestWCDBController.h"

@interface TestChangeNavController ()

@end

@implementation TestChangeNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 100, 200, 30);
    btn.layer.backgroundColor = [[UIColor greenColor] CGColor];
    btn.layer.cornerRadius = 5.f;
    btn.tag = 1;
    [btn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(20, 140, 200, 30);
    btn1.layer.backgroundColor = [[UIColor greenColor] CGColor];
    btn1.layer.cornerRadius = 5.f;
    btn1.tag = 2;
    [btn1 addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)_btnClick:(UIButton *)btn {
    if (btn.tag == 1) {
        TestWCDBController *vc = [[TestWCDBController alloc] initWithViewModel:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (btn.tag == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

@end
