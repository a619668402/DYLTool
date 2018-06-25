//
//  KFileManager.m
//  DYLTool
//
//  Created by sky on 2018/6/6.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "KFileManager.h"

@implementation KFileManager

// 获取 HomeDirectory
+ (NSString *)yl_getHomeDirectory {
    NSString *homeDirectory = NSHomeDirectory();
    return homeDirectory;
}

// 获取 Document path
+ (NSString *)yl_getDocumentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

// 获取 Cache path
+ (NSString *)yl_getCachePath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

// 获取 Library path
+ (NSString *)yl_getLibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

// 获取 Tmp path
+ (NSString *)yl_getTmpPath {
    return NSTemporaryDirectory();
}

// 判断文件是否存在
+ (BOOL)yl_isFileExistAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

// 单个文件大小
+ (unsigned long long)yl_fileSizeAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    if (isExist) {
        unsigned long long fileSize = [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
        return fileSize;
    }
    return 0;
}

// 文件夹中所有文件的大小
+ (unsigned long long)yl_folderSizeAtPath:(NSString *)folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:folderPath];
    if (isExist) {
        NSEnumerator *childFileEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
        unsigned long long folderSize = 0;
        NSString *fileName = 0;
        while ((fileName = [childFileEnumerator nextObject]) != nil) {
            NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            folderSize += [self yl_fileSizeAtPath:fileAbsolutePath];
        }
        return folderSize / (1024.0 * 1024.0);
    }
    return 0;
}

// 判断是否是文件夹
+ (BOOL)yl_isDirExist:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    return (isDir && isDirExist) ? YES : NO;
}

// 删除文件
+ (BOOL)yl_deleteFileAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:path error:nil];
}

// 创建文件夹
+ (BOOL)yl_createDir:(NSString *)dirPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:dirPath]) { // 判断 dirPath 路径文件是否存在
        return NO;
    } else {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        return YES;
    }
}

// 删除文件夹
+ (BOOL)yl_deleteDir:(NSString *)dirPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:dirPath]) {
        NSError *error = nil;
        return [fileManager removeItemAtPath:dirPath error:&error];
    }
    return NO;
}

// 移动文件夹
+ (BOOL)yl_moveDir:(NSString *)srcPath to:(NSString *)desPath {
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager moveItemAtPath:srcPath toPath:desPath error:&error];
}

// 创建文件
+ (BOOL)yl_createFile:(NSString *)filePath withData:(NSData *)data {
    return [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
}

// 读取文件
+ (NSData *)yl_readFile:(NSString *)filePath {
    return [NSData dataWithContentsOfFile:filePath options:0 error:nil];
}

// 获取文件全路径
+ (NSString *)yl_getFilePath:(NSString *)fileName {
    NSString *dirPath = [[self yl_getDocumentPath] stringByAppendingPathComponent:fileName];
    return dirPath;
}

// 在对应的文件保存数据
+ (BOOL)yl_writeDataToFile:(NSString *)fileName data:(NSData *)data {
    NSString *filePath = [self yl_getFilePath:fileName];
    return [self yl_createFile:filePath withData:data];
}

// 从对应的文件读取数据
+ (NSData *)yl_readDataFromFile:(NSString *)fileName {
    NSString *filePath = [self yl_getFilePath:fileName];
    return [self yl_readFile:filePath];
}

@end
