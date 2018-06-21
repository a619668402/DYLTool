//
//  KUserDefaults.h
//  DYLTool
//
//  Created by sky on 2018/6/20.
//  Copyright © 2018年 DYL. All rights reserved.
//  存储帮助类

#import <Foundation/Foundation.h>

@interface KSaveHelper : NSObject


/**
 保存数据(NSUserDefaults)

 @param value 保存的值
 @param key 键
 @return YES / NO
 */
+ (BOOL)saveValue:(id)value key:(NSString *)key;

+ (BOOL)saveInteger:(NSInteger)value key:(NSString *)key;

+ (BOOL)saveFloat:(float)value key:(NSString *)key;

+ (BOOL)saveDouble:(double)value key:(NSString *)key;

+ (BOOL)saveBool:(BOOL)value key:(NSString *)key;

/**
 读取保存的数据(NSUserDefaults)

 @param key value 对应的 key
 @return value
 */
+ (id)readObjectWithKey:(NSString *)key;

+ (NSInteger)readIntegerWithKey:(NSString *)key;

+ (float)readFloagWithKey:(NSString *)key;

+ (double)readDoubleWithKey:(NSString *)key;

+ (BOOL)readBoolWithKey:(NSString *)key;

@end
