//
//  YLCoreTextImageData.h
//  DYLTool
//
//  Created by sky on 2018/7/24.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLCoreTextImageData : NSObject

/// 图片资源名称
@property (nonatomic, copy) NSString *name;
/// 图片位置的起始点
@property (nonatomic, assign) CGFloat position;
/// 图片的尺寸
@property (nonatomic, assign) CGRect imagePosition;

@end
