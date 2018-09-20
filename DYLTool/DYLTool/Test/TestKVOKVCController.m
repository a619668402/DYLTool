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
    
    /*
    self.p = [Person new];
    self.p.name = @"age1";
    self.p1 = [Person new];
    self.p1.name = @"age2";
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.p addObserver:self forKeyPath:@"name" options:options context:@"测试消息"];
    */
    
    Person *p1 = [[Person alloc] init];
    [p1 setValue:@"zhangsan" forKey:@"name"];
    KLog(@"%@", [p1 valueForKey:@"name"]);
    KLog(@"%@", [p1 getname]);
    KLog(@"%@", [p1 getname1]);
}

/*
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    KLog(@"%@----%@", change, context);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.p.name = @"testAge1";
    self.p1.name = @"testAge2";
}

- (void)yl_initViews {
    [super yl_initViews];
    
    UIButton *test = [UIButton buttonWithType:UIButtonTypeCustom];
    test.frame = CGRectMake(0, KNavAndStatusHeight, 60, 35);
    test.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [test setTitle:@"Test" forState:UIControlStateNormal];
    [test setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [test addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
}

- (void)_btnClick:(UIButton *)btn {
    Person *person = [[Person alloc] init];
    person.name = @"Jack";
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([person class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        KLog(@"--- %@ : ", [NSString stringWithUTF8String:ivar_getName(ivar)]);
    }
    Ivar ivar = class_getInstanceVariable([person class], "_name");
    object_setIvar(person, ivar, @"DYL");
    KLog(@"%@  || %@", person.name, object_getIvar(person, ivar));
    free(ivars);
}
*/
@end
