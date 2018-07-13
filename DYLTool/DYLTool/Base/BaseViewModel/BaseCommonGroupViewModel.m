//
//  BaseCommonGroupViewModel.m
//  DYLTool
//
//  Created by sky on 2018/7/9.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseCommonGroupViewModel.h"

@implementation BaseCommonGroupViewModel

+ (instancetype)groupViewModel {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _footerHeight = 21;
        _headerHeight = CGFLOAT_MIN;
    }
    return self;
}

@end
