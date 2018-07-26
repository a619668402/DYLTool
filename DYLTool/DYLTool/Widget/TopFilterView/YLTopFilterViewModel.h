//
//  YLTopFilterViewModel.h
//  DYLTool
//
//  Created by sky on 2018/7/25.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
            配置信息类
 *********************************************/
#import <Foundation/Foundation.h>

@interface YLTopFilterViewModel : NSObject
/// 数据源(标题)
@property (nonatomic, copy) NSArray *dataSource;
/// 数据源(视图)
@property (nonatomic, copy) NSArray *viewSource;
/// 文字大小
@property (nonatomic, assign) CGFloat fontSize;
/// 选中文字颜色
@property (nonatomic, strong) UIColor *selectColor;
/// 默认文字颜色
@property (nonatomic, strong) UIColor *defaultColor;

@end
