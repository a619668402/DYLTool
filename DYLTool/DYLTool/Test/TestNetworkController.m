//
//  TestNetworkController.m
//  DYLTool
//
//  Created by sky on 2018/9/3.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestNetworkController.h"

@interface TestNetworkController ()

@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation TestNetworkController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initValues {
    [super yl_initValues];
    
    self.array = [NSMutableArray array];
    [self.array addObject:@"1"];
    
    NSArray *copyArray = [self.array copy];
    KLog(@"copyArray = %@", copyArray);
    [self.array addObject:@"2"];
    KLog(@"copyArray = %@", copyArray);
    KLog(@"self.array = %@", self.array);
}

- (void)yl_initViews {
    [super yl_initViews];
    
    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
    test.frame = CGRectMake(20, KNavAndStatusHeight, 100, 35);
    test.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [test setTitle:@"test" forState:UIControlStateNormal];
    [test setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [test addTarget:self action:@selector(_testBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
 
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(0, KNavAndStatusHeight + 80, KScreenWidth, 200)];
    self.img.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.img];
    // 图标编码是&#xe625，需要转成\U0000e625
    UILabel *iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 200, 50)];
    iconLabel.textColor = black_color;
    iconLabel.font = [UIFont fontWithName:@"iconfont" size:20.f];
    iconLabel.text = @"\U0000e625";
    [self.view addSubview:iconLabel];
   
   UILabel *iconLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 200, 50)];
   iconLabel1.textColor = red_color;
   iconLabel1.font = [UIFont fontWithName:@"iconfont" size:20.f];
   iconLabel1.text = @"\U0000e626";
   [self.view addSubview:iconLabel1];
}

- (void)_testBtnClick:(UIButton *)sender {
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        KLog(@"data = %@", data);
//        KLog(@"response = %@", response);
//    }] resume];
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLSessionDownloadTask *downLoadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        KLog(@"location = %@", location);
//        KLog(@"response = %@", response);
//    }];
//    [downLoadTask resume];
    /*
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535972532886&di=86cad6a12a24387bcd38f0e8a3fa074b&imgtype=0&src=http%3A%2F%2Fg.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F7af40ad162d9f2d359b91acca4ec8a136327cc6c.jpg"];
//    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/1.jpeg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    KWeakSelf(self);
    [self.img setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        KLog(@"----%@", image);
        weakself.img.image = image;
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        KLog(@"%@----", error);
    }];
     */
    
    KLog(@"主线程开始执行");
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_group_async(group, queue, ^{
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            KLog(@"线程1");
//            sleep(1);
//            KLog(@"线程1.1");
//            dispatch_semaphore_signal(semaphore);
//        });
//    });
//    dispatch_group_async(group, queue, ^{
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            KLog(@"线程2");
//            sleep(1);
//            KLog(@"线程2.1");
//            dispatch_semaphore_signal(semaphore);
//        });
//    });
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            KLog(@"线程3");
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                KLog(@"回到主线程");
            });
        });
    });
}

@end
