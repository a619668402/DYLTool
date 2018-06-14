//
//  AppDelegate+Net.h
//  NetWorkTool
//
//  Created by sky on 2018/6/14.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "AppDelegate.h"
#import "MacrosNetWork.h"

@interface AppDelegate (Net)

// 配置网络请求
- (void)configYTKNetWork;
// 网络状态监听
- (void)monitorNetwork;
@end
