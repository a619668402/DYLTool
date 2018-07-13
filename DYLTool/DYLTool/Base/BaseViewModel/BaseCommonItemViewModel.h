//
//  BaseCommonItemViewModel.h
//  DYLTool
//
//  Created by sky on 2018/7/9.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaseCommonItemViewModel : NSObject
/// 图标
@property (nonatomic, readwrite, copy) NSString *icon;
/// 标题
@property (nonatomic, readwrite, copy) NSString *title;
/// 子标题
@property (nonatomic, readwrite, copy) NSString *subTitle;
/// rowHeight, default is 44.0f
@property (nonatomic, readwrite, assign) CGFloat rowHeight;
/// default is UITableViewCellSelectionStyleGray
@property (nonatomic, readwrite, assign) UITableViewCellSelectionStyle selectionStyle;
/// 右边显示的数字标记
@property (nonatomic, readwrite, copy) NSString *badgeValue;
/// 中间偏左 icon 图片名字
@property (nonatomic, readwrite, copy) NSString *centerLeftViewName;
/// 中间偏右 icon 图片名字
@property (nonatomic, readwrite, copy) NSString *centerRightViewName;
/// 点击这行 cell 跳转到哪个视图控制器模型 destViewModelClass 必须是 BaseViewModel 的子类
@property (nonatomic, readwrite, assign) Class destViewModelClass;
/// 封装点击这行 cell 想做的事情
@property (nonatomic, readwrite, copy) void (^opeartion)(void);

/// init title or icon
+ (instancetype)itemViewModelWithTitle:(NSString *)title icon:(NSString *)icon;
/// init title
+ (instancetype)itemViewModelWithTitle:(NSString *)title;
@end
