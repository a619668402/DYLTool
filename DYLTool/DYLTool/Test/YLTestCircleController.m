//
//  YLTestCircleController.m
//  DYLTool
//
//  Created by sky on 2018/8/23.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "YLTestCircleController.h"
#import "YLCircleView.h"
#import "NSMutableAttributedString+YLTool.h"

@interface YLTestCircleController ()

@end

@implementation YLTestCircleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, KNavAndStatusHeight + 20, 100, 44);
    btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [btn setTitle:@"Click" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 300, 0)];
    label.numberOfLines = 0;
    NSMutableAttributedString *str = [NSMutableAttributedString yl_attributedWithString:@"我们发现，在遍历字典和set时，先定义了一个数组，因为根据定义，字典和set都是“无序的”，所以无法根据特定的整数下标来直接访问其中的值。于是，就必须先获取字典里的所有键或是set里的所有对象。" range:NSMakeRange(10, 20) attributed:@{NSForegroundColorAttributeName:[UIColor yellowColor], NSFontAttributeName:[UIFont systemFontOfSize:25], NSBackgroundColorAttributeName:[UIColor redColor]}];
    str = [str yl_attributedWithRange:NSMakeRange(30, 40) attributed:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"image_1.jpg"];
    attach.bounds = CGRectMake(0, -5, 20, 200);
    str = [str yl_attributedWithRange:NSMakeRange(0, 0) attributed:nil attachment:attach];
    str = [str yl_attributedWithRange:NSMakeRange(0, 0) attributed:nil attachment:attach atIndex:10];
    label.attributedText = str;
    [self.view addSubview:label];
    [label sizeToFit];
}

- (void)_btnClick:(UIButton *)sender {
    YLCircleView *testView = [[YLCircleView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:testView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.2 animations:^{
            testView.alpha = 0;
        } completion:^(BOOL finished) {
            [testView removeFromSuperview];
        }];
    });
}

@end
