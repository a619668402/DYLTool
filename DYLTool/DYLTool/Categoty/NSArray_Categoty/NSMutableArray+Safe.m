//
//  NSMutableArray+Safe.m
//  DYLTool
//
//  Created by sky on 2018/7/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "NSMutableArray+Safe.h"

@implementation NSMutableArray (Safe)

- (void)yl_addObject:(id)object {
    if (object == nil) {
        return;
    } else {
        [self addObject:object];
    }
}

- (void)yl_insertObject:(id)object atIndex:(NSUInteger)index {
    if (object == nil) {
        return;
    } else if (index > self.count) {
        return;
    } else {
        [self insertObject:object atIndex:index];
    }
}

- (void)yl_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return;
    } else {
        [self removeObjectAtIndex:index];
    }
}

- (void)yl_removeObjectsInRange:(NSRange)range {
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if ((location + length) > self.count) {
        return;
    } else {
        [self removeObjectsInRange:range];
    }
}

@end
