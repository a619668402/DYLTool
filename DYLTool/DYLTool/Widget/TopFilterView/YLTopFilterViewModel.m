//
//  YLTopFilterViewModel.m
//  DYLTool
//
//  Created by sky on 2018/7/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLTopFilterViewModel.h"

@implementation YLTopFilterViewModel

- (CGFloat)fontSize {
    if (_fontSize == 0.f) {
        return 16.0f;
    }
    return _fontSize;
}

- (UIColor *)selectColor {
    if (!_selectColor) {
        _selectColor = [UIColor blackColor];
    }
    return _selectColor;
}

- (UIColor *)defaultColor {
    if (!_defaultColor) {
        _defaultColor = [UIColor blackColor];
    }
    return _defaultColor;
}

@end
