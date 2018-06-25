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
+ (BOOL)yl_saveValue:(id)value key:(NSString *)key;

+ (BOOL)yl_saveInteger:(NSInteger)value key:(NSString *)key;

+ (BOOL)yl_saveFloat:(float)value key:(NSString *)key;

+ (BOOL)yl_saveDouble:(double)value key:(NSString *)key;

+ (BOOL)yl_saveBool:(BOOL)value key:(NSString *)key;

/**
 读取保存的数据(NSUserDefaults)

 @param key value 对应的 key
 @return value
 */
+ (id)yl_readObjectWithKey:(NSString *)key;

+ (NSInteger)yl_readIntegerWithKey:(NSString *)key;

+ (float)yl_readFloagWithKey:(NSString *)key;

+ (double)yl_readDoubleWithKey:(NSString *)key;

+ (BOOL)yl_readBoolWithKey:(NSString *)key;

@end
