//
//  MacrosConstant.m
//  DYLTool
//
//  Created by sky on 2018/7/2.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "MacrosConstant.h"

/// 网络请求相关定义
NSString * const NetworkErrorDomain = @"NetworkErrorDomain";
NSInteger const NetworkErrorCode = 7001;
NSString * const NetworkError = @"NetworkError";
NSString * const NetworkErrorInfo = @"网络错误,请检查网络";

NSString * const NetworkFailureDomain = @"NetworkFailureDomain";
NSInteger const NetworkFailureCode = 7002;
NSString * const NetworkFailure = @"NetworkFailure";
NSString * const NetworkFailureInfo = @"网络请求失败,请稍后重试";

NSString * const NetworkRequestErrorDomain = @"NetworkRequestErrorDomain";
NSInteger const NetworkRequestErrorCode = 7003;
NSString * const NetworkRequestError = @"NetworkRequestError";
/*
NSString *const CODE_SUCCESS = @"1";
NSString *const CODE_LACKPARAMETERERROR = @"-1";
NSString *const CODE_PASSWORDERROR = @"-2";
NSString *const CODE_VERIFYERROR = @"-3";
NSString *const CODE_ACCOUNTERROR = @"-4";
NSString *const CODE_NOAUTHORITYERROR = @"-5";
NSString *const CODE_SYSTEMERROR = @"-6";
NSString *const CODE_LOGICERROR = @"-7";
NSString *const CODE_TOKENERROR = @"-10";
*/
/// 全局变量
CGFloat const KGlobleLineHeight = 0.5f; // 全局分割线高度 0.5f
