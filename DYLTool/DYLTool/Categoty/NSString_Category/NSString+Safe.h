//
//  NSString+Safe.h
//  DYLTool
//
//  Created by sky on 2018/5/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Safe) // 字符串截取安全方法

- (NSString *)yl_safeSubstringFromIndex:(NSUInteger)from;

- (NSString *)yl_safeSubstringToIndex:(NSUInteger)to;

- (NSString *)yl_safeSubstringWithRange:(NSRange)range;

- (NSRange)yl_safeRangeOfString:(NSString *)aString;

- (NSRange)yl_safeRangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask;

- (NSString *)yl_safeStringByAppendingString:(NSString *)aString;

@end
