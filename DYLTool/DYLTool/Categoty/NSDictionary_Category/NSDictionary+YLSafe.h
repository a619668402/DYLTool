//
//  NSDictionary+Safe.h
//  DYLTool
//
//  Created by sky on 2018/7/26.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YLSafe)

/// 根据key获取值
///
/// @param key 键
- (id)yl_objectForKey:(NSString *)key;

- (void)yl_setValue:(id)object forKey:(id)key;

/// 根据值返回对应的key
///
/// @param value 值
- (id)yl_keyForValue:(id)value;

@end
