//
//  MacrosNetWork.h
//  DYLTool
//
//  Created by sky on 2018/6/13.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
                网络请求相关
 *********************************************/
#ifndef                           MacrosNetWork_h
#define                           MacrosNetWork_h

// 网络请求用到的头文件
#import                           "BaseRequest.h"
#import                           "BaseResponse.h"

/*
// 网络错误
#define NetworkErrorDomain        @"NerworkErrorDomain"
#define NetWorkErrorCode          7001
#define NetWorkError              @"NetWorkError"
#define NetWorkErrorInfo          @"网络错误,请检查网络"

// 请求失败
#define NetWorkFailureDomain      @"NetWorkFailureDomain"
#define NetWorkFailureCode        7002
#define NetWorkFailure            @"NetWorkFialure"
#define NetWorkFailureInfo        @"网络请求失败,请稍后重试"

// 请求错误
#define NetWorkRequestErrorDomain @"NetWorkRequestErrorDomain"
#define NetWorkRequestErrorCode   7003
#define NetWorkRequestError       @"NetWorkRequestError"
*/
// 接口返回的CODE值
#define CODE_SUCCESS              @"1"                                          // 请求正常
#define CODE_LACKPARAMETERERROR   @"-1"                                         // 缺少参数
#define CODE_PASSWORDERROR        @"-2"                                         // 密码错误
#define CODE_VERIFYERROR          @"-3"                                         // 验证码错误
#define CODE_ACCOUNTERROR         @"-4"                                         // 账号重复/错误
#define CODE_NOAUTHORITYERROR     @"-5"                                         // 没有权限访问接口
#define CODE_SYSTEMERROR          @"-6"                                         // 系统内部错误
#define CODE_LOGICERROR           @"-7"                                         // 正常业务错误
#define CODE_TOKENERROR           @"-10"                                        // token 错误

#endif /* MacrosNetWork_h */

