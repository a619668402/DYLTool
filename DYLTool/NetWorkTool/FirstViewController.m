//
//  FirstViewController.m
//  NetWorkTool
//
//  Created by sky on 2018/5/14.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "FirstViewController.h"
#import "RequestTool.h"
#import "LoginRequest.h"
#import "UserModel.h"
#import <AFNetworkReachabilityManager.h>

#import "RACNetWork.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 60, 30);
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)btnClick:(id)sender {
    
    LoginRequest *loginAPI = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500130013", @"ua_pwd":@"1"} requestMethod:YTKRequestMethodPOST];
    
    [[RACNetWork rac_Action:loginAPI] subscribeNext:^(id  _Nullable x) {
        NSLog(@"-----%@-----", x);
    } error:^(NSError * _Nullable error) {
        // 接收错误信息
        NSLog(@"-----%@-----", error);
    } completed:^{
        // 取消菊花
        NSLog(@"---completed---");
    }];
    /*
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
            default:
                break;
        }
    }];
    [mgr startMonitoring];
    /*
    LoginRequest *loginAPI1 = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500130013", @"ua_pwd":@"1"} requestMethod:YTKRequestMethodGET];
//    [RequestTool sendRequest:loginAPI resultClass:[UserModel class] success:^(UserModel *result) {
//        NSLog(@"---%@", result);
//    } failure:^(NSError *error) {
//
//    }];
    [RequestTool sendRequest:loginAPI1 resultClass:[UserModel class] cache:^(id result) {
        NSLog(@"----%@", result);
    } success:^(id result) {
        NSLog(@"-----%@", result);
    } failure:^(NSError *error) {

    }];
//    LoginRequest *loginAPI2 = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500120012", @"ua_pwd":@"2"} requestMethod:YTKRequestMethodGET];
//    LoginRequest *loginAPI3 = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500130013", @"ua_pwd":@"1"} requestMethod:YTKRequestMethodGET];
//    LoginRequest *loginAPI4 = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500120012", @"ua_pwd":@"2"} requestMethod:YTKRequestMethodGET];
//
//    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[loginAPI1,loginAPI2,loginAPI3,loginAPI4]];
//    [RequestTool sendBatchRequest:batchRequest resultClass:@[[UserModel class], [UserModel class], [UserModel class], [UserModel class]] success:^(NSArray *result) {
//        NSLog(@"----%@", result);
//    } failure:^(NSError *error) {
//
//    }];
    */
}
@end
