//
//  Category.h
//  DYLTool
//
//  Created by sky on 2018/6/6.
//  Copyright © 2018年 DYL. All rights reserved.
//

#ifndef Category_h
#define Category_h

/*********************************************
                字符串相关
 *********************************************/
#import "NSString+YLMD5.h"
#import "NSString+YLSafe.h"
#import "NSString+YLTools.h"
#import "NSString+YLBase64.h"
#import "NSString+YLPredicate.h"
#import "NSString+YLDisplayTime.h"
#import "NSAttributedString+YLExt.h"
#import "NSMutableAttributedString+YLTool.h"

#import "UIColor+YLCategory.h"                // 颜色相关

/*********************************************
                UIView  相关扩展
 *********************************************/
#import "UIView+YLFrame.h"                    // View Frame相关
#import "UIView+YLCurrentViewController.h"    // 获取当前View的控制器对象
#import "UIView+YLCornerRadius.h"             // 设置指定位置圆角
#import "UIView+YLExtendTouchRect.h"          // 增加点击响应区域

#import "UIImageView+YLLoadImg.h"             // 图片加载封装

#import "UIScrollView+YLRefresh.h"            // 上拉加载更多,下拉刷新

#import "UIBarButtonItem+YLExtension.h"       // 快速创建 UIBarButtonItem

#import "UITableView+YLExtension.h"           // 注册Cell

#import "UITextField+YLMaxLength.h"           // UITextField 设置最大长度
#import "UITextView+YLMaxLength.h"            // UITextView 设置最大长度

#import "UILabel+YLLineSpaceAndWordSpace.h"   // 行距和字间距

#import "UIButton+YLCountDown.h"              // 按钮倒计时
#import "UIButton+YLLayout.h"                 // 修改icon和文字的坐标
#import "UIButton+YLInitialize.h"             // UIButton 快速实例化

#import "UIGestureRecognizer+YLBlock.h"       // Block 实现手势

#import "UIFont+YLFontSize.h"                 // 字体适配

#import "UIImage+YLCompressImage.h"           // 图片压缩
#import "UIImage+YLTool.h"                    // 图片操作

#import "NSDateFormatter+YLExtension.h"       // 日期格式化

#import "UIViewController+YLToast.h"          // Toast 显示
#import "YLProgressHUD+YLToast.h"

/*********************************************
NSArray,NSMutableArray,NSDictionary,NSMutableDictionary Safe Method
 *********************************************/
#import "NSArray+YLSafe.h"
#import "NSMutableArray+YLSafe.h"
#import "NSDictionary+YLSafe.h"
#import "NSMutableDictionary+YLSafe.h"

#endif /* Category_h */

