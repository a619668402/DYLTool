//
//  YLFrameParser.m
//  DYLTool
//
//  Created by sky on 2018/7/24.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLFrameParser.h"
#import "YLCoreTextData.h"
#import "YLCoreTextImageData.h"
#import "YLFrameParserConfig.h"

@implementation YLFrameParser

+ (YLCoreTextData *)parstContent:(NSString *)content config:(YLFrameParserConfig *)config {
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    return [self parseAttributeContent:contentString config:config];
}

/// 方法五:接受一个NSAttributedString和一个config参数,将NSAttributedString转换成CoreTextData对象
+ (YLCoreTextData *)parseAttributeContent:(NSAttributedString *)content config:(YLFrameParserConfig *)config {
    
    // 创建CTFramesetterRef实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    // 获得要绘制区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    // 生成CTFrameRef实例
    CTFrameRef frame = [self createFrameWithFrameSetter:framesetter config:config height:textHeight];
    // 将生成好的CTFrameRef实例和计算好的绘制高度保存到CoreTextData实例中,最后返回CoreTextData实例
    YLCoreTextData *data = [[YLCoreTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;
    // 释放内存
    CFRelease(framesetter);
    CFRelease(frame);
    return data;
}

/// 方法一:用于提供对外接口,调用方法二实现从一个json模版文件中读取内容,然后调用方法五生成CoreTextData
+ (YLCoreTextData *)parseTemplateFile:(NSString *)path config:(YLFrameParserConfig *)config {
    NSMutableArray *imageArray = [NSMutableArray array];
    NSAttributedString *content = [self loadTemplateFile:path config:config];
    YLCoreTextData *data = [self parseAttributeContent:content config:config];

    return data;
}
/// 方法二:读取json文件内容,并且调用方法三从NSDictionary到NSAttributedString转换
+ (NSAttributedString *)loadTemplateFile:(NSString *)path config:(YLFrameParserConfig *)config {
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    if (data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([array isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in array) {
                NSString *type = dict[@"type"];
                if ([type isEqualToString:@"txt"]) {
                    NSAttributedString *as = [self parstAttributeContentFromNSDictionary:dict config:config];
                    [result appendAttributedString:as];
                } else if ([type isEqualToString:@"img"]) {
                    // 创建CoreTextImageData, 保存图片到imageArray数组中
                    YLCoreTextImageData *imageData = [[YLCoreTextImageData alloc] init];
                    imageData.name = dict[@"name"];
                    imageData.position = result.length;
                    
                }
            }
        }
    }
    return result;
}
/// 方法三:将NSDictionary内容转换为NSAttributedString
+ (NSAttributedString *)parstAttributeContentFromNSDictionary:(NSDictionary *)dict config:(YLFrameParserConfig *)config {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesWithConfig:config]];
    // 设置颜色
    UIColor *color = [self colorFromTemplate:dict[@"color"]];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
    }
    // 设置字号
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize > 0) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        CFRelease(fontRef);
    }
    NSString *content = dict[@"content"];
    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
}
/// 方法四:提供将NSString转换为UIColor的功能
+ (UIColor *)colorFromTemplate:(NSString *)name {
    if ([name isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    } else if ([name isEqualToString:@"red"]) {
        return [UIColor redColor];
    } else if ([name isEqualToString:@"black"]) {
        return [UIColor blackColor];
    } else {
        return nil;
    }
}

+ (NSDictionary *)attributesWithConfig:(YLFrameParserConfig *)config {
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpcing = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpcing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpcing},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpcing},
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    UIColor *textColor = config.textColor;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(fontRef);
    CFRelease(theParagraphRef);
    return dict;
}

+ (CTFrameRef)createFrameWithFrameSetter:(CTFramesetterRef)framesetter config:(YLFrameParserConfig *)config height:(CGFloat)height {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}

@end
