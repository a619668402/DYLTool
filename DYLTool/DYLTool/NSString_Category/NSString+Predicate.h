//
//  NSString+Predicate.h
//  DYLTool
//
//  Created by sky on 2018/5/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Predicate) // 正则

/**
 是否是手机号

 @return <#return value description#>
 */
- (BOOL)yl_isValidMobileNumber;


/**
 有效真实姓名

 @return <#return value description#>
 */
- (BOOL)yl_isValidRealName;


/**
 是否只有中文

 @return <#return value description#>
 */
- (BOOL)yl_isOnlyChinese;


/**
 有效的验证码(根据实际情况调整)

 @return <#return value description#>
 */
- (BOOL)yl_isValidVerifyCode;


/**
 有效银行卡号

 @return <#return value description#>
 */
- (BOOL)yl_isValidBankCardNumber;



/**
 有效邮箱

 @return <#return value description#>
 */
- (BOOL)yl_isValidEmail;


/**
 有效的字母数字密码

 @return <#return value description#>
 */
- (BOOL)yl_isValidNumberpassword;


/**
 有效身份证号码(15位)

 @return <#return value description#>
 */
- (BOOL)yl_isValidIDCard15;


/**
 有效身份证号码(18位)

 @return <#return value description#>
 */
- (BOOL)yl_idValidIDCard18;


/**
 限制只能是数字

 @return <#return value description#>
 */
- (BOOL)yl_isOnlyNumber;
@end
