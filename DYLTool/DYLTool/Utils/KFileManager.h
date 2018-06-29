//
//  KFileManager.h
//  DYLTool
//
//  Created by sky on 2018/6/6.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
                 文件管理
 *********************************************/
#import <Foundation/Foundation.h>

@interface KFileManager : NSObject

/**
 获取 HomeDirectory

 @return HomeDirectory Path
 */
+ (NSString *)yl_getHomeDirectory;

/**
 获取 Document path

 @return Document Path
 */
+ (NSString *)yl_getDocumentPath;

/**
 获取 Cache path

 @return Cache Path
 */
+ (NSString *)yl_getCachePath;

/**
 获取 Library path

 @return Library Path
 */
+ (NSString *)yl_getLibraryPath;

/**
 获取 Tmp path

 @return Tmp Path
 */
+ (NSString *)yl_getTmpPath;

/**
 判断文件是否存在

 @param path 文件名
 @return YES 存在 / NO 不存在
 */
+ (BOOL)yl_isFileExistAtPath:(NSString *)path;

/**
 单个文件大小

 @param filePath 文件路径
 @return 文件大小 单位: 字节
 */
+ (unsigned long long)yl_fileSizeAtPath:(NSString *)filePath;

/**
 文件夹中所有文件的大小

 @param folderPath 文件夹路径
 @return 文件夹大小 单位: M
 */
+ (unsigned long long)yl_folderSizeAtPath:(NSString *)folderPath;

/**
 判断是否是文件夹

 @param path 路径
 @return YES / NO
 */
+ (BOOL)yl_isDirExist:(NSString *)path;

/**
 删除文件

 @param path 文件路径
 @return YES / NO
 */
+ (BOOL)yl_deleteFileAtPath:(NSString *)path;

/**
 创建文件夹

 @param dirPath 文件夹名称(绝对路劲)
 @return YES / NO
 */
+ (BOOL)yl_createDir:(NSString *)dirPath;

/**
 删除文件夹

 @param dirPath 文件夹名称
 @return YES / NO
 */
+ (BOOL)yl_deleteDir:(NSString *)dirPath;

/**
 移动文件夹

 @param srcPath 源路径
 @param desPath 目标路径
 @return YES / NO
 */
+ (BOOL)yl_moveDir:(NSString *)srcPath to:(NSString *)desPath;

/**
 创建文件

 @param filePath 文件路径
 @param data 存储的数据
 @return YES / NO
 */
+ (BOOL)yl_createFile:(NSString *)filePath withData:(NSData *)data;

/**
 读取文件

 @param filePath 文件路径
 @return NSData
 */
+ (NSData *)yl_readFile:(NSString *)filePath;

/**
 获取Document文件夹下文件的绝对路径

 @param fileName 文件名
 @return 绝对路径
 */
+ (NSString *)yl_getFilePath:(NSString *)fileName;

/**
 在对应的文件保存数据(Document 目录下)

 @param fileName 文件名(相对路径[不需要添加 Document])
 @param data 数据
 @return YES / NO
 */
+ (BOOL)yl_writeDataToFile:(NSString *)fileName data:(NSData *)data;

/**
 从对应的文件读取数据(Document 目录下)

 @param fileName 文件名(相对路径[不需要添加 Document])
 @return NSData
 */
+ (NSData *)yl_readDataFromFile:(NSString *)fileName;

@end
