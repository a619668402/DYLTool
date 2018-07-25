//
//  YLFrameParser.h
//  DYLTool
//
//  Created by sky on 2018/7/24.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLCoreTextData.h"
@class YLFrameParserConfig;

@interface YLFrameParser : NSObject

/// 给内容配置信息
///
/// @param content 内容 
/// @param config  配置信息
+ (YLCoreTextData *)parstContent:(NSString *)content config:(YLFrameParserConfig *)config;

/// 给内容配置信息
///
/// @param content 内容
/// @param config  配置信息
+ (YLCoreTextData *)parseAttributeContent:(NSAttributedString *)content config:(YLFrameParserConfig *)config;

/// 给内容配置信息
///
/// @param path   模版文件路径
/// @param config 配置信息
+ (YLCoreTextData *)parseTemplateFile:(NSString *)path config:(YLFrameParserConfig *)config;

/// 配置信息格式化
///
/// @param config 配置信息
+ (NSDictionary *)attributesWithConfig:(YLFrameParserConfig *)config;

@end
