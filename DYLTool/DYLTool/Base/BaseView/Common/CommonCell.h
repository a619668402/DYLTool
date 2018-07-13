//
//  CommonCellTableViewCell.h
//  DYLTool
//
//  Created by sky on 2018/7/9.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonValueItemViewModel.h"
#import "CommonArrowItemViewModel.h"
#import "CommonSwitchItemViewModel.h"

@interface CommonCell : BaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

- (void)setIndexPath:(NSIndexPath *)indexPath rowInSection:(NSInteger)rows;

@end
