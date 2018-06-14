//
//  FirstViewController.m
//  NetWorkTool
//
//  Created by sky on 2018/5/14.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "FirstViewController.h"
#import "LoginRequest.h"
#import "MacrosNetWork.h"
#import "RACNetWork.h"
#import "UserModel.h"
#import "TestDownRequest.h"

@interface FirstViewController ()

@property (nonatomic, strong) TestDownRequest *request;

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
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 180, 60, 30);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancleClick:(id)sender {
    [self.request stop];
}

- (void)btnClick:(id)sender {
    
    self.request = [[TestDownRequest alloc] init];
    NSLog(@"%@", self.request.resumableDownloadPath);
//    [self.request start];
    [[RACNetWork rac_DownLoadAction:self.request] subscribeNext:^(NSProgress * _Nonnull progress) {
        NSLog(@"\n 下载进度>>>> 文件总大小：%lld 已下载：%lld",progress.totalUnitCount,progress.completedUnitCount);
    }];
//    request.resumableDownloadProgressBlock = ^(NSProgress * _Nonnull progress) {
//        NSLog(@"\n 下载进度>>>> 文件总大小：%lld 已下载：%lld",progress.totalUnitCount,progress.completedUnitCount);
//    };
    /*
    LoginRequest *request1 = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500190019", @"ua_pwd":@"1"} requestMethod:YTKRequestMethodPOST];
    LoginRequest *request2 = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500190019", @"ua_pwd":@"1"} requestMethod:YTKRequestMethodPOST];
    LoginRequest *request3 = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500200020", @"ua_pwd":@"1"} requestMethod:YTKRequestMethodPOST];
    LoginRequest *request4 = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500200020", @"ua_pwd":@"1"} requestMethod:YTKRequestMethodPOST];
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[request1,request2,request3,request4]];
    [[RACNetWork rac_BatchAction:batchRequest resultClasses:@[[UserInfoModel class],[UserInfoModel class],[UserInfoModel class], [UserInfoModel class]]] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"----%@", error);
    } completed:^{
        NSLog(@"----completed----");
    }];
     */
}
@end
