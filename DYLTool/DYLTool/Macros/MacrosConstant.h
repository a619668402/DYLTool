//
//  MacrosConstant.h
//  DYLTool
//
//  Created by sky on 2018/7/2.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
                    常量类
 *********************************************/
#import <Foundation/Foundation.h>

/// Block
typedef void (^VoidBlock)(void);
typedef BOOL (^BoolBlock)(void);
typedef int(^IntBlock)(void);
typedef id(^IDBlock)(void);

typedef void(^VoidBlock_int)(int);
typedef BOOL(^BoolBlock_int)(int);
typedef int(^IntBlock_int)(int);
typedef id(^IDBlock_int)(int);

typedef void(^VoidBlock_string)(NSString *);
typedef BOOL(^BoolBlock_string)(NSString *);
typedef int(^IntBlock_string)(NSString *);
typedef id(^IDBlock_string)(NSString *);


typedef void(^VoidBlock_id)(id);
typedef BOOL(^BoolBlock_id)(id);
typedef int(^IntBlock_id)(id);
typedef id(^IDBlock_id)(id);


/// 网络请求相关定义
FOUNDATION_EXTERN NSString * const NetworkErrorDomain;
FOUNDATION_EXTERN NSInteger const NetworkErrorCode;
FOUNDATION_EXTERN NSString * const NetworkError;
FOUNDATION_EXTERN NSString * const NetworkErrorInfo;

FOUNDATION_EXTERN NSString * const NetworkFailureDomain;
FOUNDATION_EXTERN NSInteger const NetworkFailureCode;
FOUNDATION_EXTERN NSString * const NetworkFailure;
FOUNDATION_EXTERN NSString * const NetworkFailureInfo;

FOUNDATION_EXTERN NSString * const NetworkRequestErrorDomain;
FOUNDATION_EXTERN NSInteger const NetworkRequestErrorCode;
FOUNDATION_EXTERN NSString * const NetworkRequestError;


/// 全局变量
FOUNDATION_EXTERN CGFloat const KGlobleLineHeight; // 分割线高度
