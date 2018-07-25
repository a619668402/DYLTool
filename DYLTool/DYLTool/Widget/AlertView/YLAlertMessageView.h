//
//  YLAlertView.h
//  DYLTool
//
//  Created by sky on 2018/7/19.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLAlertMessageView;
@protocol YLAlertMessageViewDeleage <NSObject>

@optional
- (void)yl_AlertMessageViewOtherBtnClick;

@end

@interface YLAlertMessageView : UIView

@property (nonatomic, weak) id<YLAlertMessageViewDeleage> delegate;

/// 初始化 AlertView
/// @param title 标题
/// @param message 内容
/// @param cancleBtnTitle 取消按钮
/// @param otherBtnTitle 确定按钮
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancleBtnTitle:(NSString *)cancleBtnTitle otherBtnTitle:(NSString *)otherBtnTitle;

- (void)show;

@end
