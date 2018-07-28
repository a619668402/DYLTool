//
//  NSString+Tools.h
//  DYLTool
//
//  Created by sky on 2018/5/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Tools)


/**
 电话号码中间4位*显示

 @param phoneNumber 电话号码
 @return eg:135****0001
 */
+ (NSString *)yl_getSecrectStringWithPhoneNumber:(NSString *)phoneNumber;


/**
 银行卡号中间8位*显示

 @param accountNumber 银行卡号
 @return <#return value description#>
 */
+ (NSString *)yl_getSecrectStringWithAccountNumber:(NSString *)accountNumber;


/**
 转为手机格式,默认为-

 @param mobile 手机号
 @return <#return value description#>
 */
+ (NSString *)yl_stringMobileFormat:(NSString *)mobile;


/**
 金额数字添加单位

 @param value 金额
 @return <#return value description#>
 */
+ (NSString *)yl_stringChineseFormat:(double)value;


/**
 数字添加千分位

 @param num <#num description#>
 @return eg:###,###,##
 */
+ (NSString *)yl_countNumAndChangeFormat:(NSString *)num;


/**
 计算文字宽度

 @param fontSize 字体
 @param maxHeight 最大高度
 @return <#return value description#>
 */
- (CGFloat)yl_widthWithFontSize:(CGFloat)fontSize height:(CGFloat)maxHeight;


/**
 计算文字高度

 @param fontSize 字体
 @param width 最大宽度
 @return <#return value description#>
 */
- (CGFloat)yl_heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width;

/**
 移除小数末尾的0

 @return <#return value description#>
 */
- (NSString *)yl_removeUnwantedZero;


/**
 去掉前后空格

 @return <#return value description#>
 */
- (NSString *)yl_trimmedString;

/**
 返回字符串中的所有数字

 @return 字符串中的所有数字
 */
- (NSString *)yl_allNumberOfString;

/**
 返回字符串中的数字(第一次出现的数字)

 @return 字符串中的数字
 */
- (NSString *)yl_numberOfString;

@end
