//
//  NSArray+Safe.h
//  DYLTool
//
//  Created by sky on 2018/7/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)

+ (instancetype)yl_arrayWithObject:(id)object;

- (id)yl_objectAtIndex:(NSUInteger)index;

- (NSArray *)yl_subArrayWithRange:(NSRange)range;

- (NSUInteger)yl_indexOfObject:(id)anObject;

@end
