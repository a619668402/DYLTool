//
//  ViewController.m
//  DYLTool
//
//  Created by sky on 2018/5/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "ViewController.h"
#import "TestSearchController.h"
#import "YLAlertMessageView.h"
#import "YLAlertController.h"
#import "TestWebController.h"

#import "ArrowLabel.h"
#import "YLButton.h"
#import "UIButton+Layout.h"

#import "YLDisplayView.h"
#import "YLFrameParser.h"
#import "YLFrameParserConfig.h"
#import "YLCoreTextData.h"

@interface ViewController ()

@property (nonatomic, strong) UISearchBar *mBar;

@property (nonatomic, strong) UIButton *mBtn;

@property (nonatomic, strong) RACCommand *mBtnCommand;

@property (nonatomic, strong) ArrowLabel *label;

@property (nonatomic, strong) UIButton *btn1;

@property (nonatomic, strong) YLButton *btn2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCoreText];
}

- (void)yl_initViews {
    [self.view addSubview:self.mBar];
    [self.view addSubview:self.mBtn];
    [self.view addSubview:self.label];
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    
    
}

- (void)createCoreText {
    YLDisplayView *displayView = [[YLDisplayView alloc] initWithFrame:CGRectMake(10, 180, KScreenWidth, 400)];
    displayView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:displayView];
    
    // 设置配置信息
    YLFrameParserConfig *config = [[YLFrameParserConfig alloc] init];
    config.width = displayView.yl_width;
    config.textColor = [UIColor greenColor];
    config.fontSize = 11.0f;
    
    /*
    NSString *content = @"CoreText是用于处理文字和字体的底层技术。"
    "它直接和Core Graphics(又被称为Quartz)打交道。"
    "Quartz是一个2D图形渲染引擎，能够处理OSX和iOS中图形显示问题。"
    "Quartz能够直接处理字体（font）和字形（glyphs），将文字渲染到界面上，它是基础库中唯一能够处理字形的模块。"
    "因此CoreText为了排版，需要将显示的文字内容、位置、字体、字形直接传递给Quartz。"
    "与其他UI组件相比，由于CoreText直接和Quartz来交互，所以它具有更高效的排版功能。";
    // 设置富文本
    NSDictionary *attr = [YLFrameParser attributesWithConfig:config];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:content attributes:attr];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19.0f] range:NSMakeRange(0, 20)];
    [attributeString addAttribute:(NSString *)kCTForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 20)];
    */
    
    // 获取模版文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonFile" ofType:@"txt"];
    
    // 设置内容
//    YLCoreTextData *data = [YLFrameParser parseAttributeContent:attributeString config:config];
    YLCoreTextData *data = [YLFrameParser parseTemplateFile:path config:config];
    displayView.data = data;
    [displayView yl_setHeight:data.height];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)yl_initValues {
//    _mBtnCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        TestSearchController *vc = [[TestSearchController alloc] initWithViewModel:nil];
////        [self.navigationController pushViewController:vc animated:YES];
//        return [RACSignal empty];
//    }];
}

- (UISearchBar *)mBar {
    if (!_mBar) {
        _mBar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 0, KScreenWidth - 30, 44)];
        _mBar.barStyle = UIBarStyleDefault;
        _mBar.placeholder = @"请输入搜索内容";
    }
    return _mBar;
}

- (UIButton *)mBtn {
    if (!_mBtn) {
        _mBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _mBtn.backgroundColor = red_color;
        _mBtn.frame = CGRectMake((KScreenWidth - 60) / 2, 120, 60, 44);
//        _mBtn.rac_command = _mBtnCommand;
        [_mBtn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mBtn;
}

- (ArrowLabel *)label {
    if (!_label) {
        _label = [[ArrowLabel alloc] initWithFrame:CGRectMake((KScreenWidth - 100) / 2, 280, 100, 50)];
        _label.backgroundColor = [UIColor redColor];
    }
    return _label;
}

- (UIButton *)btn1 {
    if (!_btn1) {
        _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn1 setTitle:@"test" forState:UIControlStateNormal];
        [_btn1 setImage:[UIImage imageNamed:@"ff_IconShowAlbum_25x25"] forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn1 setImageRect:CGRectMake(20, 5, 30, 30)];
        [_btn1 setTitleRect:CGRectMake(0, 40, 70, 20)];
        _btn1.frame = CGRectMake(280 / 2, 120, 70, 65);
        [_btn1 addTarget:self action:@selector(_btn1Click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

- (void)_btn1Click {
    TestWebController *vc = [[TestWebController alloc] initWithViewModel:nil];
    vc.urlString = @"https://www.baidu.com";
    vc.jsString = @"alert('sfsdfadfa')";
    [self.navigationController pushViewController:vc animated:YES];
}

- (YLButton *)btn2 {
    if (!_btn2) {
        _btn2 = [YLButton buttonWithType:UIButtonTypeCustom];
        [_btn2 setTitle:@"BTN2" forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"ff_IconShowAlbum_25x25"] forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn2 setTitleRect:CGRectMake(0, 5, 70, 20)];
        [_btn2 setImageRect:CGRectMake(20, 30, 30, 30)];
        _btn2.frame = CGRectMake(20, 120, 70, 65);
    }
    return _btn2;
}

- (void)test {
    /*
    YLAlertMessageView *alertView1 = [[YLAlertMessageView alloc] initWithTitle:@"Test" message:@"Test AlertView" cancleBtnTitle:@"Cancle" otherBtnTitle:@"Sure"];
    [alertView1 show];
     */
    
    YLAlertController *alertController = [YLAlertController alertWithViewController];
    [self presentViewController:alertController animated:NO completion:^{
        
    }];
}

@end
