//
//  NSMutableAttributedString+YLTool.m
//  DYLTool
//
//  Created by sky on 2018/9/21.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "NSMutableAttributedString+YLTool.h"

@implementation NSMutableAttributedString (YLTool)

+ (NSMutableAttributedString *)yl_attributedWithString:(NSString *)string range:(NSRange)range attributed:(NSDictionary *)attribute {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    for (NSString *key in attribute.allKeys) {
        [attr addAttribute:key value:attribute[key] range:range];
    }
    return attr;
}

- (NSMutableAttributedString *)yl_attributedWithRange:(NSRange)range attributed:(NSDictionary *)attribute {
    for (NSString *key in attribute.allKeys) {
        [self addAttribute:key value:attribute[key] range:range];
    }
    return self;
}

+ (NSMutableAttributedString *)yl_attributedWithString:(NSString *)string range:(NSRange)range attributed:(NSDictionary *)attribute attachment:(NSTextAttachment *)attachment atIndex:(NSInteger)index {
    NSMutableAttributedString *attr = [NSMutableAttributedString yl_attributedWithString:string range:range attributed:attribute];
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attachment];
    [attr insertAttributedString:str atIndex:index];
    return attr;
}

+ (NSMutableAttributedString *)yl_attributedWithString:(NSString *)string range:(NSRange)range attributed:(NSDictionary *)attribute attachment:(NSTextAttachment *)attachment {
    NSMutableAttributedString *attr = [NSMutableAttributedString yl_attributedWithString:string range:range attributed:attribute];
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attachment];
    [attr appendAttributedString:str];
    return attr;
}

- (NSMutableAttributedString *)yl_attributedWithRange:(NSRange)range attributed:(NSDictionary *)attribute attachment:(NSTextAttachment *)attachment atIndex:(NSInteger)index {
    for (NSString *key in attribute.allKeys) {
        [self addAttribute:key value:attribute[key] range:range];
    }
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attachment];
    [self insertAttributedString:str atIndex:index];
    return self;
}

- (NSMutableAttributedString *)yl_attributedWithRange:(NSRange)range attributed:(NSDictionary *)attribute attachment:(NSTextAttachment *)attachment {
    for (NSString *key in attribute.allKeys) {
        [self addAttribute:key value:attribute[key] range:range];
    }
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attachment];
    [self appendAttributedString:str];
    return self;
}

@end
