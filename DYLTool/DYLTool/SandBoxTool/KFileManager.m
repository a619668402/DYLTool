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
+ (NSString *)getHomeDirectory {
    NSString *homeDirectory = NSHomeDirectory();
    return homeDirectory;
}

// 获取 Document path
+ (NSString *)getDocumentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

// 获取 Cache path
+ (NSString *)getCachePath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

// 获取 Library path
+ (NSString *)getLibraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

// 获取 Tmp path
+ (NSString *)getTmpPath {
    return NSTemporaryDirectory();
}

// 判断文件是否存在
+ (BOOL)isFileExistAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

// 单个文件大小
+ (unsigned long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    if (isExist) {
        unsigned long long fileSize = [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
        return fileSize;
    }
    return 0;
}

// 文件夹中所有文件的大小
+ (unsigned long long)folderSizeAtPath:(NSString *)folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:folderPath];
    if (isExist) {
        NSEnumerator *childFileEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
        unsigned long long folderSize = 0;
        NSString *fileName = 0;
        while ((fileName = [childFileEnumerator nextObject]) != nil) {
            NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fileAbsolutePath];
        }
        return folderSize / (1024.0 * 1024.0);
    }
    return 0;
}

// 判断是否是文件夹
+ (BOOL)isDirExist:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    return (isDir && isDirExist) ? YES : NO;
}

// 删除文件
+ (BOOL)deleteFileAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:path error:nil];
}

// 创建文件夹
+ (BOOL)createDir:(NSString *)dirPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:dirPath]) { // 判断 dirPath 路径文件是否存在
        return NO;
    } else {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        return YES;
    }
}

// 删除文件夹
+ (BOOL)deleteDir:(NSString *)dirPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:dirPath]) {
        NSError *error = nil;
        return [fileManager removeItemAtPath:dirPath error:&error];
    }
    return NO;
}

// 移动文件夹
+ (BOOL)moveDir:(NSString *)srcPath to:(NSString *)desPath {
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager moveItemAtPath:srcPath toPath:desPath error:&error];
}

// 创建文件
+ (BOOL)createFile:(NSString *)filePath withData:(NSData *)data {
    return [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
}

// 读取文件
+ (NSData *)readFile:(NSString *)filePath {
    return [NSData dataWithContentsOfFile:filePath options:0 error:nil];
}

// 获取文件全路径
+ (NSString *)getFilePath:(NSString *)fileName {
    NSString *dirPath = [[self getDocumentPath] stringByAppendingPathComponent:fileName];
    return dirPath;
}

// 在对应的文件保存数据
+ (BOOL)writeDataToFile:(NSString *)fileName data:(NSData *)data {
    NSString *filePath = [self getFilePath:fileName];
    return [self createFile:filePath withData:data];
}

// 从对应的文件读取数据
+ (NSData *)readDataFromFile:(NSString *)fileName {
    NSString *filePath = [self getFilePath:fileName];
    return [self readFile:filePath];
}

@end
