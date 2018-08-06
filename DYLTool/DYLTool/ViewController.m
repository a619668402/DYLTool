//
//  ViewController.m
//  DYLTool
//
//  Created by sky on 2018/5/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewController.h"
#import "TestWebController.h"
#import "TestFilterViewController.h"
#import "TestTZImagePickerController.h"
#import "TestHXPhotoPicker.h"
#import "TestInputViewController.h"
#import "TestBasicAnimationController.h"
#import "TestThreadController.h"
#import "KQRCodeController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)yl_initViews {
    [super yl_initViews];
    [self.view addSubview:self.tableView];
}

- (void)yl_initValues {
    [super yl_initValues];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KNavAndStatusHeight, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
        _tableView.rowHeight = 44.0f;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)data {
    if (!_data) {
        _data = @[@"HXPhotoPicker", @"TZImagePickerController", @"YLInputView", @"TestCABasicAnimation", @"TestThread", @"TestTableView", @"QRCodeScan"];
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
            TestInputViewController *vc = [[TestInputViewController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            TestBasicAnimationController *vc = [[TestBasicAnimationController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            TestThreadController *vc = [[TestThreadController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            TestTableViewController *vc = [[TestTableViewController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            KQRCodeController *vc = [[KQRCodeController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark ************* UITableView Delegate and DataSource End   *************

@end
