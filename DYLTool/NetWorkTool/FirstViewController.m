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
    
    [btn rac_command];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancleClick:(id)sender {
    [self.request stop];
}

- (void)btnClick:(id)sender {
    
//    self.request = [[TestDownRequest alloc] init];
//    NSLog(@"%@", self.request.resumableDownloadPath);
//    [self.request start];
//    request.resumableDownloadProgressBlock = ^(NSProgress * _Nonnull progress) {
//        NSLog(@"\n 下载进度>>>> 文件总大小：%lld 已下载：%lld",progress.totalUnitCount,progress.completedUnitCount);
//    };
    LoginRequest *request1 = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500190019", @"ua_pwd":@"1"} requestMethod:YTKRequestMethodPOST];
    LoginRequest *request2 = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500190019", @"ua_pwd":@"1"} requestMethod:YTKRequestMethodPOST];
    LoginRequest *request3 = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500200020", @"ua_pwd":@"1"} requestMethod:YTKRequestMethodPOST];
    LoginRequest *request4 = [LoginRequest requestWithParameter:@{@"ua_mobile":@"13500200020", @"ua_pwd":@"1"} requestMethod:YTKRequestMethodPOST];
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[request2,request3,request4]];
//    [self showIndicatorView];
//    [[RACNetWork rac_BatchAction:batchRequest resultClasses:@[[UserInfoModel class],[UserInfoModel class],[UserInfoModel class], [UserInfoModel class]]] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@-------%d", x, [[NSThread currentThread] isMainThread]);
//    } error:^(NSError * _Nullable error) {
//        [self dismissIndicatorView];
//        NSLog(@"----%@, ----%d", error, [[NSThread currentThread] isMainThread]);
//    } completed:^{
//        [self dismissIndicatorView];
//        NSLog(@"----completed----%d", [[NSThread currentThread] isMainThread]);
//    }];
    
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//
//        [[RACNetWork rac_Action:request1 resultClass:nil] subscribeNext:^(id  _Nullable x) {
//            [subscriber sendNext:x];
//        } error:^(NSError * _Nullable error) {
//            [subscriber sendError:error];
//        } completed:^{
//            NSLog(@"----------");
//            [subscriber sendCompleted];
//            NSLog(@"-------------------------");
//        }];
//
//        return [RACDisposable disposableWithBlock:^{
//
//        }];
//    }];

    RACSignal *singal = [RACNetWork rac_Action:request1 resultClass:nil];
    
    [singal subscribeNext:^(id  _Nullable x) {
        NSLog(@"----%@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"----%@,", error);
    } completed:^{
        NSLog(@"====completed====");
    }];
    
    
//    2018-06-15 15:37:22.658360+0800 NetWorkTool[5772:248817] ----------
//    2018-06-15 15:37:22.658464+0800 NetWorkTool[5772:248817] ====completed====
//    2018-06-15 15:37:22.658551+0800 NetWorkTool[5772:248817] -------------------------
    
    
//    2018-06-15 15:38:04.507083+0800 NetWorkTool[5811:249717] ====completed====
//    2018-06-15 15:38:04.507320+0800 NetWorkTool[5811:249717] ----------
//    2018-06-15 15:38:04.507417+0800 NetWorkTool[5811:249717] -------------------------
}

- (void) showIndicatorView {
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.bounds = CGRectMake(0, 0,100, 100);
    indicatorView.center = self.view.center;
    indicatorView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:indicatorView];
    indicatorView.tag = 10;
    [indicatorView startAnimating];
}

- (void)dismissIndicatorView {
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[self.view viewWithTag:10];
    if (indicatorView.isAnimating) {
        [indicatorView stopAnimating];
    }
    [indicatorView removeFromSuperview];
}

@end
