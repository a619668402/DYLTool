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
+ (BOOL)yl_saveValue:(id)value key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    return [defaults synchronize];
}

+ (BOOL)yl_saveInteger:(NSInteger)value key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:key];
    return [defaults synchronize];
}

+ (BOOL)yl_saveFloat:(float)value key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:value forKey:key];
    return [defaults synchronize];
}

+ (BOOL)yl_saveDouble:(double)value key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:value forKey:key];
    return [defaults synchronize];
}

+ (BOOL)yl_saveBool:(BOOL)value key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    return [defaults synchronize];
}

#pragma mark ----- NSUserDefaults 读取操作 -----
+ (id)yl_readObjectWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (NSInteger)yl_readIntegerWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (float)yl_readFloagWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}

+ (double)yl_readDoubleWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:key];
}

+ (BOOL)yl_readBoolWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end
