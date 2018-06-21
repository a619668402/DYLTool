//
//  ViewController.m
//  Base
//
//  Created by sky on 2018/6/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+Toast.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];

    [MBProgressHUD showMessageWithView:self.view message:@"测试Toast测试Toast测试Toast测试Toast测试Toast测试Toast测试Toast测试Toast测试Toast测试Toast测试Toast"];

    [self performSelector:@selector(show) withObject:nil afterDelay:1];
}

- (void)show {
    [MBProgressHUD showMessageWithView:self.view message:@"测"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TestViewController *vc    = [[TestViewController alloc] initWithParameter:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

