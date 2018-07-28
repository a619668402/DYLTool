//
//  NSMutableArray+Safe.h
//  DYLTool
//
//  Created by sky on 2018/7/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safe)

- (void)yl_addObject:(id)object;

- (void)yl_insertObject:(id)object atIndex:(NSUInteger)index;

- (void)yl_removeObjectAtIndex:(NSUInteger)index;

- (void)yl_removeObjectsInRange:(NSRange)range;

@end
