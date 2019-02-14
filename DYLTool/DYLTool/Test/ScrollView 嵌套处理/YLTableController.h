//
//  YLTableController.h
//  DYLTool
//
//  Created by sky on 2019/1/11.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "BaseViewController.h"

@protocol YLTableControllerDelegate <NSObject>

- (void)tableControllerLeaveTop;

@end

@interface YLTableController : BaseViewController

@property (nonatomic, weak, readwrite) id<YLTableControllerDelegate> delegate;

- (void)makeTableControllerScroll:(BOOL)canScroll;

- (void)makeTableControllerScrollToTop;

@end
