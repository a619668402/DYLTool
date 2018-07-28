//
//  NSArray+Safe.m
//  DYLTool
//
//  Created by sky on 2018/7/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

+ (instancetype)yl_arrayWithObject:(id)object {
    if (object == nil) {
        return [self array];
    } else {
        return [self arrayWithObject:object];
    }
}

- (id)yl_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    } else {
        return [self objectAtIndex:index];
    }
}

- (NSUInteger)yl_indexOfObject:(id)anObject {
    if (anObject == nil) {
        return NSNotFound;
    } else {
        return [self indexOfObject:anObject];
    }
}

- (NSArray *)yl_subArrayWithRange:(NSRange)range {
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    if (location + length > self.count) {
        if ((location + length) > self.count) {
            length = (self.count - location);
            return [self yl_subArrayWithRange:NSMakeRange(location, length)];
        }
        return nil;
    } else {
        return [self subarrayWithRange:range];
    }
}

@end
