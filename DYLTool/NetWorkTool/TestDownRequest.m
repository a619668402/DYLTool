//
//  TestDownRequest.m
//  NetWorkTool
//
//  Created by sky on 2018/6/14.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestDownRequest.h"

@implementation TestDownRequest

- (NSString *)requestUrl {
    return @"dl/android/studio/install/3.1.2.0/android-studio-ide-173.4720617-windows.exe";
}

- (NSString *)resumableDownloadPath {
    NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *cachePath = [libPath stringByAppendingPathComponent:@"Caches"];
//    NSString *filePath = [cachePath stringByAppendingPathComponent:@"test"];
//    NSLog(@"%@", filePath);
    return [NSString stringWithFormat:@"%@/Android_Studio.dmg",libPath];
}

- (AFURLSessionTaskProgressBlock)resumableDownloadProgressBlock {
    AFURLSessionTaskProgressBlock block =  ^(NSProgress * _Nonnull progress) {
//        NSLog(@"\n 下载进度>>>> 文件总大小：%lld 已下载：%lld",progress.totalUnitCount,progress.completedUnitCount);
    };
    return block;
}

@end
