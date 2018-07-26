//
//  YLTopFilterView.h
//  DYLTool
//
//  Created by sky on 2018/7/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLTopFilterViewModel.h"

@interface YLTopFilterView : UIView

/// 配置信息
@property (nonatomic, strong) YLTopFilterViewModel *viewModel;

- (instancetype)initWithFrame:(CGRect)frame viewModel:(YLTopFilterViewModel *)viewModel;

@end
