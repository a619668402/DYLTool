//
//  RACNetWork.h
//  NetWorkTool
//
//  Created by sky on 2018/6/1.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork.h>
#import <ReactiveObjC.h>

#import "MacrosNetWork.h"
#import "BaseRequest.h"

@interface RACNetWork : NSObject


+ (RACSignal *)rac_Action:(BaseRequest *)request;

@end
