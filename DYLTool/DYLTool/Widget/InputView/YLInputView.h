//
//  YLInputView.h
//  DYLTool
//
//  Created by sky on 2018/7/30.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLInputView;

@protocol YLInputViewDelegate <NSObject>

- (void)yl_inputView:(YLInputView *)inputView inputContent:(NSString *)sendContent;

@end

@interface YLInputView : UIView
/// 背景颜色
@property (nonatomic, strong) UIColor *bgColor;
/// 文本输入框
@property (nonatomic, strong) UITextView *textInput;
/// 设置输入框最大行数
@property (nonatomic, assign) NSInteger textViewMaxLine;
/// textView 占位符
@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, weak) id<YLInputViewDelegate> delegate;

@property (nonatomic, copy) void(^keyIsVisiableBlock)(BOOL keyboardIsVisiable);

/// 发送成功
- (void)sendSuccessEndEditing;

@end
