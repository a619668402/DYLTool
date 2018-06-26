//
//  ViewController.m
//  DYLTool
//
//  Created by sky on 2018/5/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "ViewController.h"
#import "MacrosHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
    NSString *str = @"1231";
    NSLog(@"%@", [str md5String]);
     */
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    kCornerRadius(view, 25.0f);
    kBorderWithAndColor(view, 10, [UIColor redColor]);
 
//     NSString *str = @"ONE";
//    NSLog(@"%x", &str);
//    str = @"TWO";
//    NSLog(@"%x", &str);
//    NSLog(@"%@", str);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClick:(UIButton *)sender {
}


@end
