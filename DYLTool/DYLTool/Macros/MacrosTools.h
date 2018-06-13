//
//  MacrosTools.h
//  DYLTool
//
//  Created by sky on 2018/6/12.
//  Copyright © 2018年 DYL. All rights reserved.
//

#ifndef MacrosTools_h
#define MacrosTools_h

/**
 判断字符串是否为空

 @param str 字符串
 @return 返回 YES / NO
 */
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull null]] || str == nil || str.length < 1 ? YES : NO)

/**
 判断数据是否为空

 @param array 数组
 @return 返回 YES / NO
 */
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

/**
 判断字典是否为空

 @param dic 字典
 @return 返回 YES / NO
 */
#define kDicIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

/**
 判断是否是空对象

 @param _object 对象
 @return 返回 YES / NO
 */
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

/**
 获取屏幕宽度
 */
#define kScreenWidth \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)

/**
 获取屏幕高度
 */
#define kScreenHeight \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)

/**
 获取屏幕 Bounds
 */
#define kScreenSize \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)


// Application 对象
#define kApplication [UIApplication sharedApplication]
// Window 对象
#define kKeyWindow   [UIApplication sharedApplication].keyWindow
#define kAppDelegate [UIApplication sharedApplication].delegate

// APP 版本号
#define kAppVersion  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 系统版本号
#define kSystemVersion  [[UIDevice currentDevice] systemVersion]

// 自定义打印信息
#ifdef DEBUG
#define kLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define kLog(...)
#endif

#define kWeakSelf(type) __weak typeof(type) weak##type = type
#define kStrongSelf(type) __strong typeof(type) type   = weak##type

// GCD
// 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onckBlock);
// 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
// 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);

// 设置圆角
#define kCornerRadius(view, radius) [view.layer setCornerRadius:(radius)]; [view.layer setMasksToBounds:YES];
// 设置边框
#define kBorderWithAndColor(view, width, color) [view.layer setBorderWidth:(width)]; [view.layer setBorderColor:[color CGColor]];

#endif /* MacrosTools_h */

