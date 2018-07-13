//
//  BaseCommonGroupViewModel.h
//  DYLTool
//
//  Created by sky on 2018/7/9.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaseCommonGroupViewModel : NSObject
/// 组头
@property (nonatomic, copy) NSString *header;
/// headerHeight default is .001
@property (nonatomic, readwrite, assign) CGFloat headerHeight;
/// 组尾
@property (nonatomic, copy) NSString *footer;
/// footerHeight defalut is 21
@property (nonatomic, readwrite, assign) CGFloat footerHeight;
/// 存放 BaseCommonItemViewModel 及其子类
@property (nonatomic, strong) NSArray *itemViewModels;

+ (instancetype)groupViewModel;
@end
