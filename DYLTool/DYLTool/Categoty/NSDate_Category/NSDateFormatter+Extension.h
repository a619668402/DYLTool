//
//  NSDateFormatter+Extension.h
//  DYLTool
//
//  Created by sky on 2018/6/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Extension)

/**
 NSDateFormatter 对象

 @return NSDateFormatter 对象
 */
+ (instancetype)yl_dataFormatter;

/**
 设置格式

 @param dateFormat 格式
 @return NSDateFormatter 对象
 */
+ (instancetype)yl_dateFormatterWithFormat:(NSString *)dateFormat;

/**
 默认格式

 @return yyyy/MM/dd HH:mm:ss
 */
+ (instancetype)yl_defaultDateFromatter;

@end
