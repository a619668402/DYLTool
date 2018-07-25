//
//  YLFrameParserConfig.m
//  DYLTool
//
//  Created by sky on 2018/7/24.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLFrameParserConfig.h"

@implementation YLFrameParserConfig

- (instancetype)init {
    if (self = [super init]) {
        _width = 200.f;
        _fontSize = 15.0f;
        _lineSpace = 8.0f;
        _textColor = [UIColor blackColor];
    }
    return self;
}

@end
