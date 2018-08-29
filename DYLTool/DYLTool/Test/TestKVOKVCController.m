//
//  TestKVOKVCController.m
//  DYLTool
//
//  Created by sky on 2018/8/28.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestKVOKVCController.h"

#import "Person.h"

@interface TestKVOKVCController ()

@property (nonatomic, strong) Person *p;

@property (nonatomic, strong) Person *p1;

@end

@implementation TestKVOKVCController

- (void)dealloc {
    [self.p removeObserver:self forKeyPath:@"name"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initValues {
    [super yl_initValues];
    
    /*
    Person *p = [Person new];
    [p setValue:@"TestName" forKey:@"name"];
    [p setValue:@"value" forKey:@"age"];
    [p setValue:@"东城小学" forKeyPath:@"student.schoolName"];
    [p setValue:[NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil] forKeyPath:@"testArray"];
//    KLog(@"p.name = %@", p.name);
//    KLog(@"_name = %@",[p getname]);
//    KLog(@"schoolName = %@", p.student.schoolName);
//    KLog(@"%@", [p valueForKeyPath:@"student.schoolName"]);
//    KLog(@"%@", [p valueForKeyPath:@"name"]);
//    KLog(@"testArray = %@", [p valueForKey:@"testArray"]);
//    KLog(@"testArray = %@", [p mutableArrayValueForKey:@"testArray"]);
    
    [p addItem];
    KLog(@"testArray = %@", [p valueForKey:@"testArray"]);
    [p removeItem];
    KLog(@"testArray = %@", [p valueForKey:@"testArray"]);
    [p addItemObserver];
    KLog(@"testArray = %@", [p valueForKey:@"testArray"]);
    [p removeItemObserver];
    KLog(@"testArray = %@", [p mutableArrayValueForKey:@"testArray"]);
     */
    
    self.p = [Person new];
    self.p.name = @"age1";
    self.p1 = [Person new];
    self.p1.name = @"age2";
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.p addObserver:self forKeyPath:@"name" options:options context:@"测试消息"];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    KLog(@"%@----%@", change, context);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.p.name = @"testAge1";
    self.p1.name = @"testAge2";
}

- (void)yl_initViews {
    [super yl_initViews];
}

@end
