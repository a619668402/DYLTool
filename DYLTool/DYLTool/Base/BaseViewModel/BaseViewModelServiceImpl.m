//
//  BaseViewModelServiceImpl.m
//  DYLTool
//
//  Created by sky on 2018/7/4.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseViewModelServiceImpl.h"

@implementation BaseViewModelServiceImpl

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark ************* BaseNavigationProtocol Start *************

- (void)pushViewModel:(BaseViewModel *)viewModel animated:(BOOL)animated {}

- (void)popViewModelAnimated:(BOOL)animated {}

- (void)popToRootViewModelAnimated:(BOOL)animated {}

- (void)presentViewModel:(BaseViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)resetRootViewModel:(BaseViewModel *)viewModel {}

#pragma mark ************* BaseNavigationProtocol End   *************

@end
