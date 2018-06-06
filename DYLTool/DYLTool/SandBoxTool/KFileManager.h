//
//  KFileManager.h
//  DYLTool
//
//  Created by sky on 2018/6/6.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFileManager : NSObject

/**
 获取 HomeDirectory

 @return <#return value description#>
 */
+ (NSString *)getHomeDirectory;

/**
 获取 Document path

 @return <#return value description#>
 */
+ (NSString *)getDocumentPath;

/**
 获取 Cache path

 @return <#return value description#>
 */
+ (NSString *)getCachePath;

/**
 获取 Library path

 @return <#return value description#>
 */
+ (NSString *)getLibraryPath;

/**
 获取 Tmp path

 @return <#return value description#>
 */
+ (NSString *)getTmpPath;

/**
 判断文件是否存在

 @param path 文件名
 @return YES 存在 / NO 不存在
 */
+ (BOOL)isFileExistAtPath:(NSString *)path;

/**
 单个文件大小

 @param filePath 文件路径
 @return 文件大小 单位: 字节
 */
+ (unsigned long long)fileSizeAtPath:(NSString *)filePath;

/**
 文件夹中所有文件的大小

 @param folderPath 文件夹路径
 @return 文件夹大小 单位: M
 */
+ (unsigned long long)folderSizeAtPath:(NSString *)folderPath;

/**
 判断是否是文件夹

 @param path 路径
 @return YES / NO
 */
+ (BOOL)isDirExist:(NSString *)path;

/**
 删除文件

 @param path 文件路径
 @return YES / NO
 */
+ (BOOL)deleteFileAtPath:(NSString *)path;

@end
