//
//  YLCoreTextUtils.h
//  DYLTool
//
//  Created by sky on 2018/7/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLCoreTextLinkData.h"
#import "YLCoreTextData.h"

@interface YLCoreTextUtils : NSObject

/// 检测点击位置是否在链接上
///
/// @param view     点击区域
/// @param point    点击坐标
/// @param data     数据源
+ (YLCoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(YLCoreTextData *)data;

@end
