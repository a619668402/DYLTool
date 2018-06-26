//
//  UITableView+Extension.h
//  DYLTool
//
//  Created by sky on 2018/6/26.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
                注册Cell
 *********************************************/
#import <UIKit/UIKit.h>

@interface UITableView (Extension)

/**
 注册Cell,identifier和类名保持一致
 NSString *identifier = NSStringFromClass([UITableViewCell class])
 @param cls <#cls description#>
 */
- (void)yl_registerCell:(Class)cls;
- (void)yl_registerNibCell:(Class)cls;

- (void)yl_registerCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier;
- (void)yl_registerNibCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIndetifier;

@end
