//
//  YLCoreTextData.h
//  DYLTool
//
//  Created by sky on 2018/7/24.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import "YLCoreTextImageData.h"

@interface YLCoreTextData : NSObject

@property (nonatomic, assign) CTFrameRef ctFrame;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) NSArray *linkArray;

@end
