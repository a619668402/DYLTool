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
#import "TestLottieController.h"
#import "TestScrollController.h"
#import "TestCollectionController.h"
#import "YLAlertController.h"
#import "YLNavController.h"
#import "YLShareView.h"
#import "YLTestCircleController.h"
#import "TestDragCollectionController.h"
#import "TestBezierPathController.h"
#import "TestKVOKVCController.h"
#import "TestNetworkController.h"
#import "TestWCDBController.h"
#import "TestOpenGLESController.h"
#import "TestChangeNavController.h"

#import "PresentingAnimationController.h"
#import "DismissingAnimationController.h"

#import "UIGestureRecognizer+YLBlock.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate>

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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.rowHeight = 44.0f;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)data {
    if (!_data) {
        _data = @[@"HXPhotoPicker", @"TZImagePickerController", @"YLInputView", @"TestCABasicAnimation", @"TestThread", @"TestTableView", @"QRCodeScan", @"TestLottie", @"TestScrollView", @"TestCollectionView", @"TestAlertController", @"TestNavController", @"TestYLShareView", @"TestCircleView", @"TestDragCollection", @"TestFilterController",@"TestBezierPath", @"TestKVOKVC", @"TestNetwork", @"TestWCDB",
            @"TestOpenGLES", @"TestChangeNav"];
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
        case 7:
        {
            TestLottieController *vc = [[TestLottieController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 8:
        {
            TestScrollController *vc = [[TestScrollController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 9:
        {
            TestCollectionController *vc = [[TestCollectionController alloc] initWithViewModel:nil];
            CATransition *anim = [CATransition animation];
            anim.duration = 0.5f;
            anim.type = @"moveln";
            anim.subtype = kCATransitionFromRight;
            anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            [self.navigationController.view.layer addAnimation:anim forKey:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10:
        {
            [self.view addGestureRecognizer:[UITapGestureRecognizer yl_gestureRecognizerWithActionBlock:^(id gestureRecognizer) {
                KLogFunc;
            }]];
            
//            YLAlertController *vc = [[YLAlertController alloc] init];
//            vc.transitioningDelegate = self;
//            vc.modalPresentationStyle = UIModalPresentationCustom;
//            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 11:
        {
            YLNavController *nav = [[YLNavController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:nav animated:YES];
        }
            break;
        case 12:
        {
            YLShareView *shareView = [[YLShareView alloc] init];
            [shareView showShareView];
        }
            break;
        case 13:
        {
            YLTestCircleController *vc = [[YLTestCircleController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 14:
        {
            TestDragCollectionController *vc = [[TestDragCollectionController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 15:
        {
            TestFilterViewController *vc = [[TestFilterViewController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 16:
        {
            TestBezierPathController *vc = [[TestBezierPathController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 17:
        {
            TestKVOKVCController *vc = [[TestKVOKVCController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 18:
        {
            TestNetworkController *vc = [[TestNetworkController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 19:
        {
            TestWCDBController *vc = [[TestWCDBController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 20:
        {
//            TestOpenGLESController *vc = [[TestOpenGLESController alloc] initWithViewModel:nil];
//            [self.navigationController pushViewController:vc animated:YES];
            TestOpenGLESController *vc = [[TestOpenGLESController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 21:
        {
            TestChangeNavController *vc = [[TestChangeNavController alloc] initWithViewModel:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark ************* UITableView Delegate and DataSource End   *************

#pragma mark ************* UIViewControllerTransitioningDelegate Start *************
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[PresentingAnimationController alloc] init];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DismissingAnimationController alloc] init];
}
#pragma mark ************* UIViewControllerTransitioningDelegate End   *************

@end
