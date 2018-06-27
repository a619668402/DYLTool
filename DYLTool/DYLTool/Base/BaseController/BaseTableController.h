//
//  BaseTableController.h
//  DYLTool
//
//  Created by sky on 2018/6/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseTableController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
// TableView
@property (nonatomic, readonly, weak) UITableView *tableView;
// tableView 内容缩进, default is UIEdgeInsetsMake(64, 0, 0, 0)
@property (nonatomic, readonly, assign) UIEdgeInsets contentInset;

- (void)reloadData;

@end
