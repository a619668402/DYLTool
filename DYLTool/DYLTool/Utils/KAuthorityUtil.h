//
//  KAuthorityUtil.h
//  DYLTool
//
//  Created by sky on 2018/8/8.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
                权限判断
 *********************************************/
#import <Foundation/Foundation.h>

@interface KAuthorityUtil : NSObject

/**
 麦克风权限

 @return YES / NO
 */
+ (BOOL)canRecord;

/**
 相机权限

 @return YES / NO
 */
+ (BOOL)canRecordVideo;

/**
 相册权限

 @return YES / NO
 */
+ (BOOL)albumAuthority;

/**
 定位权限

 @return YES / NO
 */
+ (BOOL)locationAuthority;
@end
