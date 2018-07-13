//
//  CommonHeaderView.h
//  DYLTool
//
//  Created by sky on 2018/7/10.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonHeaderView : UITableViewHeaderFooterView<BaseTableCellProtocol>

/// generate a header
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
