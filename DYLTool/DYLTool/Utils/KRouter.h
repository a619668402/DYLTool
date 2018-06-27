//
//  KRouter.h
//  DYLTool
//
//  Created by sky on 2018/6/27.
//  Copyright © 2018年 DYL. All rights reserved.
//
/***********************************
    ViewModel - ViewController
 ***********************************/
#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "BaseViewModel.h"

@interface KRouter : NSObject

/**
 Retrieves the shared router instance

 @return shared router instance
 */
+ (instancetype)shareInstance;

/**
 Retrieves the view corresponding to the given viewModel

 @param viewModel the view model
 @return ViewController
 */
- (BaseViewController *)viewControllerFromViewModel:(BaseViewModel *)viewModel;

@end
