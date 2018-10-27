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
#pragma mark ************* Block Start *************
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

#pragma mark ************* Block End   *************

#pragma mark ************* NetWork Define(网络相关定义) Start *************
/// 网络请求相关定义
FOUNDATION_EXTERN NSString * const KNetworkErrorDomain;
FOUNDATION_EXTERN NSInteger const KNetworkErrorCode;
FOUNDATION_EXTERN NSString * const KNetworkError;
FOUNDATION_EXTERN NSString * const KNetworkErrorInfo;

FOUNDATION_EXTERN NSString * const KNetworkFailureDomain;
FOUNDATION_EXTERN NSInteger const KNetworkFailureCode;
FOUNDATION_EXTERN NSString * const KNetworkFailure;
FOUNDATION_EXTERN NSString * const KNetworkFailureInfo;

FOUNDATION_EXTERN NSString * const KNetworkRequestErrorDomain;
FOUNDATION_EXTERN NSInteger const KNetworkRequestErrorCode;
FOUNDATION_EXTERN NSString * const KNetworkRequestError;
/*
 FOUNDATION_EXTERN NSString *const CODE_SUCCESS;
 FOUNDATION_EXTERN NSString *const CODE_LACKPARAMETERERROR;
 FOUNDATION_EXTERN NSString *const CODE_PASSWORDERROR;
 FOUNDATION_EXTERN NSString *const CODE_VERIFYERROR;
 FOUNDATION_EXTERN NSString *const CODE_ACCOUNTERROR;
 FOUNDATION_EXTERN NSString *const CODE_NOAUTHORITYERROR;
 FOUNDATION_EXTERN NSString *const CODE_SYSTEMERROR;
 FOUNDATION_EXTERN NSString *const CODE_LOGICERROR;
 FOUNDATION_EXTERN NSString *const CODE_TOKENERROR;
 */
#pragma mark ************* NetWork Define(网络相关定义) End   *************

#pragma mark ************* 全局变量 Start *************
/// 全局变量
FOUNDATION_EXTERN CGFloat const KGlobleLineHeight; // 分割线高度
#pragma mark ************* 全局变量 End   *************
