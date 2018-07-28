//
//  NSMutableDictionary+Safe.m
//  DYLTool
//
//  Created by sky on 2018/7/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"

@implementation NSMutableDictionary (Safe)

- (void)yl_setObject:(id)object forKey:(id<NSCopying>)key {
    if (object && ![object isKindOfClass:[NSNull class]] && key) {
        [self setObject:object forKey:key];
    } else {
        return;
    }
}

- (id)yl_objectForKey:(id<NSCopying>)key {
    if (key == nil) {
        return [self objectForKey:key];
    } else {
        return nil;
    }
}

@end
