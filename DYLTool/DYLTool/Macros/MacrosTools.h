//
//  MacrosTools.h
//  DYLTool
//
//  Created by sky on 2018/6/12.
//  Copyright © 2018年 DYL. All rights reserved.
//
/*********************************************
                    常用的宏
 *********************************************/

#ifndef MacrosTools_h
#define MacrosTools_h

#import "KFileManager.h"
#import "KSaveHelper.h"

/**
 判断字符串是否为空

 @param str 字符串
 @return 返回 YES / NO
 */
#define KStringIsEmpty(str) ([str isKindOfClass:[NSNull null]] || str == nil || str.length < 1 ? YES : NO)

/**
 判断数据是否为空

 @param array 数组
 @return 返回 YES / NO
 */
#define KArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

/**
 判断字典是否为空

 @param dic 字典
 @return 返回 YES / NO
 */
#define KDicIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

/**
 判断是否是空对象

 @param _object 对象
 @return 返回 YES / NO
 */
#define KObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

/**
 获取屏幕宽度
 */
#define KScreenWidth \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)

/**
 获取屏幕高度
 */
#define KScreenHeight \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)

/**
 获取屏幕 Bounds
 */
#define KScreenSize \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)

/**
 状态栏+导航栏高度
 */
#define KNavAndStatusHeight self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height


// Application 对象
#define KApplication [UIApplication sharedApplication]
// Window 对象
#define KKeyWindow   [UIApplication sharedApplication].keyWindow
#define KAppDelegate [UIApplication sharedApplication].delegate

// APP 版本号
#define KAppVersion  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 系统版本号
#define KSystemVersion  [[UIDevice currentDevice] systemVersion]

// 自定义打印信息
#ifdef DEBUG
#define KLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define KLog(...)
#endif

#define KWeakSelf(type) __weak typeof(type) weak##type = type
#define KStrongSelf(type) __strong typeof(type) type   = weak##type

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

// 正常字体
#define N_8 [UIFont systemFontOfSize:8]
#define N_9 [UIFont systemFontOfSize:9]
#define N_10 [UIFont systemFontOfSize:10]
#define N_11 [UIFont systemFontOfSize:11]
#define N_12 [UIFont systemFontOfSize:12]
#define N_13 [UIFont systemFontOfSize:13]
#define N_14 [UIFont systemFontOfSize:14]
#define N_15 [UIFont systemFontOfSize:15]
#define N_16 [UIFont systemFontOfSize:16]
#define N_17 [UIFont systemFontOfSize:17]
#define N_18 [UIFont systemFontOfSize:18]
#define N_19 [UIFont systemFontOfSize:19]
#define N_20 [UIFont systemFontOfSize:20]
#define N_21 [UIFont systemFontOfSize:21]
#define N_22 [UIFont systemFontOfSize:22]
#define N_23 [UIFont systemFontOfSize:23]
#define N_24 [UIFont systemFontOfSize:24]
#define N_25 [UIFont systemFontOfSize:25]
#define N_26 [UIFont systemFontOfSize:26]
#define N_27 [UIFont systemFontOfSize:27]
#define N_28 [UIFont systemFontOfSize:28]

// 粗体
#define B_8 [UIFont boldSystemFontOfSize:8]
#define B_9 [UIFont boldSystemFontOfSize:9]
#define B_10 [UIFont boldSystemFontOfSize:10]
#define B_11 [UIFont boldSystemFontOfSize:11]
#define B_12 [UIFont boldSystemFontOfSize:12]
#define B_13 [UIFont boldSystemFontOfSize:13]
#define B_14 [UIFont boldSystemFontOfSize:14]
#define B_15 [UIFont boldSystemFontOfSize:15]
#define B_16 [UIFont boldSystemFontOfSize:16]
#define B_17 [UIFont boldSystemFontOfSize:17]
#define B_18 [UIFont boldSystemFontOfSize:18]
#define B_19 [UIFont boldSystemFontOfSize:19]
#define B_20 [UIFont boldSystemFontOfSize:20]
#define B_21 [UIFont boldSystemFontOfSize:21]
#define B_22 [UIFont boldSystemFontOfSize:22]
#define B_23 [UIFont boldSystemFontOfSize:23]
#define B_24 [UIFont boldSystemFontOfSize:24]
#define B_25 [UIFont boldSystemFontOfSize:25]
#define B_26 [UIFont boldSystemFontOfSize:26]
#define B_27 [UIFont boldSystemFontOfSize:27]
#define B_28 [UIFont boldSystemFontOfSize:28]

// 常用颜色
#define black_color     [UIColor blackColor]
#define blue_color      [UIColor  blueColor]
#define clear_color     [UIColor clearColor]
#define white_color     [UIColor whiteColor]
#define red_color       [UIColor   redColor]
#define gray_color      [UIColor  grayColor]
#define green_color     [UIColor greenColor]

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


// 图片路径
#define PNGPATH(NAME)       [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)       [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define KPATH(NAME, EXT)    [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// 加载图片
#define PNGImg(NAME)    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGImg(NAME)    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define KIMG(NAME, EXT) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]
#define M_IMG(IMGNAME)  [UIImage imageNamed:IMGNAME]


// 字符串
#define KURL(url)                            [NSURL URLWithString:url]
#define KStringWithFormat(string, args...)  [NSString stringWithFormat:string, args]
#define KS_INT(int)                         [NSString stringWithFormat:@"%d", num]
#define KS_INTEGER(integer)                 [NSString stringWithFormat:@"%ld", integer]

#endif /* MacrosTools_h */

