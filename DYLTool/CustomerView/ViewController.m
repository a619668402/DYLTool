//
//  ViewController.m
//  CustomerView
//
//  Created by sky on 2018/6/7.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "ViewController.h"
#import "TGWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TGWebViewController *vc = [[TGWebViewController alloc] init];
    vc.urlString = @"https://www.baidu.com";
//    vc.jsString = @"alert('1')";
    vc.loadingProgressColor = [UIColor grayColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
