//
//  BaseTableCellProtocol.h
//  Base
//
//  Created by sky on 2018/6/21.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseTableCellProtocol <NSObject>

@required
- (void)yl_setUp;
// 初始化子控件
- (void)yl_setUpChildViews; 
@optional
- (void)yl_bindModel:(id)viewModel;

@end
