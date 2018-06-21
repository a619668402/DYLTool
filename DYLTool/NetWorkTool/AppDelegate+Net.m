//
//  AppDelegate+Net.m
//  NetWorkTool
//
//  Created by sky on 2018/6/14.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "AppDelegate+Net.h"

@implementation AppDelegate (Net)

- (void)configYTKNetWork {
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    [agent setValue:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html",@"text/css", nil] forKeyPath:@"_manager.responseSerializer.acceptableContentTypes"];
    [YTKNetworkConfig sharedConfig].baseUrl = @"https://tj2admin.tigonetwork.com";
//    [YTKNetworkConfig sharedConfig].baseUrl = @"https://dl.google.com";
}

- (void)monitorNetwork {
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
}

@end
