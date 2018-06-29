//
//  BaseTableController.h
//  DYLTool
//
//  Created by sky on 2018/6/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

#import "BaseViewController.h"
#import "BaseTableViewModel.h"

#import "UIScrollView+Refresh.h"
#import "UITableView+Extension.h"

#import "MacrosTools.h"

@interface BaseTableController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
// TableView
@property (nonatomic, readonly, weak) UITableView *tableView;
/// tableView 内容缩进, default is UIEdgeInsetsMake((statuesheight + navbarheight), 0, 0, 0) iPhoneX is 88, other is 64
@property (nonatomic, readonly, assign) UIEdgeInsets contentInset;

/// reload tableView data, sub class can override
- (void)reloadData;

/// dequeueReusableCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

/// configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@end
