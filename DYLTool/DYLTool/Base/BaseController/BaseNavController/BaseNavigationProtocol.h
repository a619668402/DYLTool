//
//  BaseNavigationProtocol.h
//  DYLTool
//
//  Created by sky on 2018/7/4.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacrosConstant.h"
#import "BaseViewModel.h"

@protocol BaseNavigationProtocol <NSObject>

/// Pushes the corresponding View controller
///
/// Use a horizontal slide transition
/// Has no effect if the corresponding view controller it already in the stack
///
/// viewModel - the view model
/// animated  - use animation or not
- (void)pushViewModel:(BaseViewModel *)viewModel animated:(BOOL)animated;

/// Pops the top view controller in the stack.
///
/// animated - use animation or not
- (void)popViewModelAnimated:(BOOL)animated;

/// Pops until there's only a single view controller left on the stack
///
/// animated - use animation or not
- (void)popToRootViewModelAnimated:(BOOL)animated;

/// Present the corresponding view controller
///
/// viewModel  - the view model
/// animated   - use animation or not
/// completion - the completion handler
- (void)presentViewModel:(BaseViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

/// Dismiss the presented view controller
///
/// animated   - use animation or not
/// completion - the completion handler
- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;

/// Reset the corresponding view controller as the root view controller of the application's window
///
/// viewModel - the view model
- (void)resetRootViewModel:(BaseViewModel *)viewModel;
@end
