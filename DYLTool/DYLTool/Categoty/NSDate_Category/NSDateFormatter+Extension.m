//
//  NSDateFormatter+Extension.m
//  DYLTool
//
//  Created by sky on 2018/6/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "NSDateFormatter+Extension.h"

@implementation NSDateFormatter (Extension)

+ (instancetype)yl_dataFormatter {
    return [[self alloc] init];
}

+ (instancetype)yl_dateFormatterWithFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (instancetype)yl_defaultDateFromatter {
    return [self yl_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
@end
