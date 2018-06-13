//
//  ViewController.m
//  EmptyView
//
//  Created by sky on 2018/5/25.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "ViewController.h"
#import "PlaceholderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated {
    PlaceholderView *placeHolderView = [[PlaceholderView alloc] initWithFrame:self.view.frame type:PlaceholderViewTypeNoData delegate:nil];
    [self.view addSubview:placeHolderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
