//
//  NSString+Safe.h
//  DYLTool
//
//  Created by sky on 2018/5/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Safe) // 字符串截取安全方法

- (NSString *)safeSubstringFromIndex:(NSUInteger)from;

- (NSString *)safeSubstringToIndex:(NSUInteger)to;

- (NSString *)safeSubstringWithRange:(NSRange)range;

- (NSRange)safeRangeOfString:(NSString *)aString;

- (NSRange)safeRangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask;

- (NSString *)safeStringByAppendingString:(NSString *)aString;

@end
