//
//  ViewController.m
//  DYLTool
//
//  Created by sky on 2018/5/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "ViewController.h"
#import "TestSearchController.h"
#import "TestWebController.h"
#import "TestFilterViewController.h"
#import "TestTZImagePickerController.h"
#import "TestHXPhotoPicker.h"
#import "TestInputViewController.h"

#import "YLAlertMessageView.h"
#import "YLAlertController.h"
#import "ArrowLabel.h"
#import "YLButton.h"
#import "UIButton+Layout.h"
#import "YLInputView.h"

#import "YLDisplayView.h"
#import "YLFrameParser.h"
#import "YLFrameParserConfig.h"
#import "YLCoreTextData.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, YLInputViewDelegate>

@property (nonatomic, strong) UISearchBar *mBar;

@property (nonatomic, strong) UIButton *mBtn;

@property (nonatomic, strong) RACCommand *mBtnCommand;

@property (nonatomic, strong) ArrowLabel *label;

@property (nonatomic, strong) UIButton *btn1;

@property (nonatomic, strong) YLButton *btn2;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) YLInputView *inputView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, KNavAndStatusHeight, 50, 30);
    btn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btn];
    
}

- (void)yl_initViews {
    [super yl_initViews];
    [self.view addSubview:self.mBtn];
    [self.view addSubview:self.mBar];
    [self.view addSubview:self.label];
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.tableView];
    
    [self createInputView];
}

- (void)createInputView {
    self.inputView = [[YLInputView alloc] initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, 50)];
    self.inputView.textViewMaxLine = 4;
    self.inputView.delegate = self;
    self.inputView.placeholderLabel.text = @"请输入......";
    [self.view addSubview:self.inputView];
}

- (void)yl_inputView:(YLInputView *)inputView inputContent:(NSString *)sendContent {
    [self.inputView.textInput resignFirstResponder];
    KLog(@"-------%@", sendContent);
    [self.inputView sendSuccessEndEditing];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.inputView.textInput resignFirstResponder];
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
    
    // 获取模版文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonFile" ofType:@"txt"];
    
    // 设置内容
//    YLCoreTextData *data = [YLFrameParser parseAttributeContent:attributeString config:config];
    YLCoreTextData *data = [YLFrameParser parseTemplateFile:path config:config];
    displayView.data = data;
    displayView.yl_height = data.height;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)yl_initValues {
    [super yl_initValues];
    _mBtnCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        TestSearchController *vc = [[TestSearchController alloc] initWithViewModel:nil];
        [self.navigationController pushViewController:vc animated:YES];
        return [RACSignal empty];
    }];
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
        _mBtn.frame = CGRectMake((KScreenWidth - 60) / 2, 0, 60, 44);
        _mBtn.rac_command = _mBtnCommand;
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
        [_btn1 setTitle:@"WebController" forState:UIControlStateNormal];
        [_btn1 setImage:[UIImage imageNamed:@"ff_IconShowAlbum_25x25"] forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn1 setImageRect:CGRectMake(20, 5, 30, 30)];
        [_btn1 setTitleRect:CGRectMake(0, 40, 70, 20)];
        _btn1.frame = CGRectMake(KScreenWidth - 20 - 70, 120, 70, 65);
        [_btn1 addTarget:self action:@selector(_btn1Click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

- (void)_btn1Click {
    TestWebController *vc = [[TestWebController alloc] initWithViewModel:nil];
    vc.urlString = @"https://www.baidu.com";
    vc.jsString = @"alert('sfsdfadfa')";
}

- (YLButton *)btn2 {
    if (!_btn2) {
        _btn2 = [YLButton buttonWithType:UIButtonTypeCustom];
        [_btn2 setTitle:@"PopView" forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"ff_IconShowAlbum_25x25"] forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn2 setTitleRect:CGRectMake(0, 5, 70, 20)];
        [_btn2 setImageRect:CGRectMake(20, 30, 30, 30)];
        _btn2.frame = CGRectMake(20, 120, 70, 65);
        [_btn2 addTarget:self action:@selector(_btn2Click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

- (void)_btn2Click {
    /*
    TestFilterViewController *vc = [[TestFilterViewController alloc] initWithViewModel:nil];
    [self.navigationController pushViewController:vc animated:YES];
     */
    [self.inputView.textInput becomeFirstResponder];
}

- (void)test {
    YLAlertMessageView *alertView1 = [[YLAlertMessageView alloc] initWithTitle:@"Test" message:@"Test AlertView" cancleBtnTitle:@"Cancle" otherBtnTitle:@"Sure"];
    [alertView1 show];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.btn2.yl_y + self.btn2.yl_height + 70, KScreenWidth, KScreenHeight - self.btn2.yl_y - self.btn2.yl_height - 10) style:UITableViewStylePlain];
        _tableView.rowHeight = 44.0f;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)data {
    if (!_data) {
        _data = @[@"HXPhotoPicker", @"TZImagePickerController", @"YLInputView"];
    }
    return _data;
}

#pragma mark ************* UITableView Delegate and DataSource Start *************

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell1"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell1"];
    }
    cell.textLabel.text = self.data[indexPath.item];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.item) {
        case 0:
        {
            TestHXPhotoPicker *vc = [[TestHXPhotoPicker alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            TestTZImagePickerController *vc = [[TestTZImagePickerController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
//            TestInputViewController *vc = [[TestInputViewController alloc] init];
            TestInputViewController *vc = [[TestInputViewController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark ************* UITableView Delegate and DataSource End   *************

@end
