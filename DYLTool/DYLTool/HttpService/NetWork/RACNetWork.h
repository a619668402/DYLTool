//
//  RACNetWork.h
//  NetWorkTool
//
//  Created by sky on 2018/6/1.
//  Copyright © 2018年 DYL. All rights reserved.
//

@interface RACNetWork : NSObject

/**
 单个请求

 @param request 请求类
 @param resultClass 泛型
 @return 请求结果的RAC信号
 */
+ (RACSignal *_Nonnull)rac_Action:(BaseRequest *_Nonnull)request resultClass:(Class _Nonnull)resultClass;

/**
 批量请求(所有请求成功才返回成功,有一个失败就返回)

 @param batchRequest 批量请求类
 @param resultClasses 请求结果的泛型集合(需和批量请求类中的顺序对应)
 @return 请求结果的信号量
 */
+ (RACSignal *_Nonnull)rac_BatchAction:(YTKBatchRequest *_Nonnull)batchRequest resultClasses:(NSArray<Class> *_Nonnull)resultClasses;

@end
