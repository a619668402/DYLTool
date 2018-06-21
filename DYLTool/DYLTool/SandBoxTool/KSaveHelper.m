//
//  KUserDefaults.m
//  DYLTool
//
//  Created by sky on 2018/6/20.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "KSaveHelper.h"

@implementation KSaveHelper

#pragma mark ----- NSUserDefaults 保存操作 -----
+ (BOOL)saveValue:(id)value key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    return [defaults synchronize];
}

+ (BOOL)saveInteger:(NSInteger)value key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:key];
    return [defaults synchronize];
}

+ (BOOL)saveFloat:(float)value key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:value forKey:key];
    return [defaults synchronize];
}

+ (BOOL)saveDouble:(double)value key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:value forKey:key];
    return [defaults synchronize];
}

+ (BOOL)saveBool:(BOOL)value key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    return [defaults synchronize];
}

#pragma mark ----- NSUserDefaults 读取操作 -----
+ (id)readObjectWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (NSInteger)readIntegerWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (float)readFloagWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}

+ (double)readDoubleWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:key];
}

+ (BOOL)readBoolWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end
