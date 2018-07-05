//
//  BaseNavigationControllerStack.h
//  DYLTool
//
//  Created by sky on 2018/7/4.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>

@protocol BaseViewModelServices;

@interface BaseNavigationControllerStack : NSObject

/// Initialization Method. This is the preferred way to create a new navigation controller stack
///
/// services - The services bus of the 'Model' layer
///
/// Return a new navigation controller stack
- (instancetype)initWithServiecs:(id<BaseViewModelServices>)services;

/// Pushes the navigation Controller
///
/// navigationController - the navigation controller
- (void)pushNavigationController:(UINavigationController *)navigationController;

/// Pops the top navigation controller in the stack
///
/// Returns the poped navigation controller
- (UINavigationController *)popNavigationController;

/// Retrieves the top navigation controller in the stack
///
/// Returns the top navigation controller in the stack
- (UINavigationController *)topNavigationController;

@end
