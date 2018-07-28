//
//  NSMutableDictionary+Safe.h
//  DYLTool
//
//  Created by sky on 2018/7/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Safe)

- (void)yl_setObject:(id)object forKey:(id<NSCopying>)key;

- (id)yl_objectForKey:(id<NSCopying>)key;

@end
