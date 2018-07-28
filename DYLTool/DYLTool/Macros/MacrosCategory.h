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
#import "NSString+MD5.h"
#import "NSString+Safe.h"
#import "NSString+Tools.h"
#import "NSString+base64.h"
#import "NSString+Predicate.h"
#import "NSString+DisplayTime.h"
#import "NSAttributedString+Ext.h"

#import "UIColor+Category.h"                // 颜色相关

/*********************************************
                UIView  相关扩展
 *********************************************/
#import "UIView+Frame.h"                    // View Frame相关
#import "UIView+CurrentViewController.h"    // 获取当前View的控制器对象
#import "UIImageView+LoadImg.h"             // 图片加载封装
#import "UIScrollView+Refresh.h"            // 上拉加载更多,下拉刷新
#import "UIBarButtonItem+Extension.h"       // 快速创建 UIBarButtonItem
#import "UITableView+Extension.h"           // 注册Cell
#import "UITextField+MaxLength.h"           // UITextField 设置最大长度
#import "UITextView+MaxLength.h"            // UITextView 设置最大长度
#import "UIButton+CountDown.h"              // 按钮倒计时
#import "UILabel+LineSpaceAndWordSpace.h"   // 行距和字间距
#import "UIButton+Layout.h"                 // 修改icon和文字的坐标

#import "UIFont+fontSize.h"                 // 字体适配
#import "UIImage+CompressImage.h"           // 图片压缩
#import "UIImage+Tool.h"                    // 图片操作
#import "NSDateFormatter+Extension.h"       // 日期格式化
#import "UIViewController+Toast.h"          // Toast 显示
#import "MBProgressHUD+Toast.h"

/*********************************************
NSArray,NSMutableArray,NSDictionary,NSMutableDictionary Safe Method
 *********************************************/
#import "NSArray+Safe.h"
#import "NSMutableArray+Safe.h"
#import "NSDictionary+Safe.h"
#import "NSMutableDictionary+Safe.h"

#endif /* Category_h */

