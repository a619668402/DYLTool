//
//  TestThreadController.m
//  DYLTool
//
//  Created by sky on 2018/8/2.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestThreadController.h"
#import "TestCustomOperation.h"

@interface TestThreadController ()

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIButton *operationBtn;

@property (nonatomic, strong) UIButton *customOperationBtn;

@property (nonatomic, strong) UIButton *gcdBtn;

@property (nonatomic, strong) UIButton *centerBtn;

@property (nonatomic, strong) UIView *tempView;

@end

@implementation TestThreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)yl_initViews {
    [super yl_initViews];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.operationBtn];
    [self.view addSubview:self.customOperationBtn];
    [self.view addSubview:self.gcdBtn];
    [self.view addSubview:self.centerBtn];
    
    self.tempView = [UIView new];
    self.tempView.backgroundColor = red_color;
    [self.view addSubview:self.tempView];
    
    KWeakSelf(self);
    [self.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.view.mas_centerX).offset(0);
        make.centerY.equalTo(weakself.view.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.centerBtn.mas_bottom).offset(5);
        make.left.right.equalTo(weakself.view).offset(0);
        make.height.mas_equalTo(20);
    }];
}

- (void)_threadSelector {
    KLogFunc;
    for (int i = 0; i < 100000; i ++) {
        KLog(@"----------------%d ------%@", i, [NSDate date]);
        if (i == 300) {
//            [NSThread sleepForTimeInterval:3];
//            [[NSThread currentThread] cancel];
            [NSThread exit];
        }
    }
}

- (void)_operation {
    for (int i = 0; i < 200000; i ++) {
        KLog(@"%d", i);
    }
}

- (void)_btnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 1:
        {
            KLog(@"%d", [NSThread isMainThread]);
//            [NSThread detachNewThreadSelector:@selector(_threadSelector) toTarget:self withObject:nil];
            
//            [NSThread detachNewThreadWithBlock:^{
//                for (int i = 0; i < 100; i ++) {
//                    KLog(@"%d", i);
//                }
//            }];
            
            NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(_threadSelector) object:nil];
            [thread start];
        }
            break;
        case 2:
        {
            /*
            NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(_operation) object:nil];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            queue.maxConcurrentOperationCount = 4;
            [queue addOperation:operation];
            */
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                for (int i = 0; i < 1000; i ++) {
                    KLog(@"%d", i);
                }
            }];
            [[[NSOperationQueue alloc] init] addOperation:operation];
        }
            break;
        case 3:
        {
            TestCustomOperation *test = [[TestCustomOperation alloc] init];
            /*
            KLog(@"start before");
            [test start];
            KLog(@"start after");
             */
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [queue setMaxConcurrentOperationCount:3];
            [queue addOperation:test];
        }
            break;
        case 4:
        {
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            for (int i = 0; i < 100; i ++) {
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                dispatch_async(queue, ^{
                    KLog(@"-----%d", i);
                    sleep(2);
                    dispatch_semaphore_signal(semaphore);
                });
            }
        }
            break;
        default:
            break;
    }
}

- (UIButton *)centerBtn {
    if (!_centerBtn) {
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _centerBtn.bounds = CGRectMake(0, 0, 50, 50);
//        _centerBtn.center = self.view.center;
        _centerBtn.backgroundColor = [UIColor blackColor];
        _centerBtn.touchExtendInset = UIEdgeInsetsMake(-20, -20, -20, -20);
        @weakify(self);
        [[_centerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            KLogFunc;
            _centerBtn.selected = !_centerBtn.selected;
            @strongify(self);
            [self.view setNeedsUpdateConstraints];
            [UIView animateWithDuration:0.5 animations:^{
                [self.centerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(_centerBtn.selected ? 200 : 100);
                    make.height.mas_equalTo(_centerBtn.selected ? 200 : 100);
                    make.centerY.equalTo(self.view.mas_centerY).offset(0);
                    make.centerX.equalTo(self.view.mas_centerX).offset(0);
                }];
                [self.view layoutIfNeeded];
            }];
        }];
    }
    return _centerBtn;
}

- (UIButton *)gcdBtn {
    if (!_gcdBtn) {
        _gcdBtn = [UIButton yl_initWithFrame:CGRectMake(KScreenWidth - 80, KNavAndStatusHeight + 45, 80, 40) buttonType:UIButtonTypeCustom title:@"GCD" backgroundColor:[UIColor blackColor] target:self selector:@selector(_btnClick:)];
        _gcdBtn.tag = 4;
    }
    return _gcdBtn;
}

- (UIButton *)customOperationBtn {
    if (!_customOperationBtn) {
        _customOperationBtn = [UIButton yl_initWithFrame:CGRectMake(0, KNavAndStatusHeight + 45, 80, 40) buttonType:UIButtonTypeCustom title:@"CustomOperation" backgroundColor:red_color target:self selector:@selector(_btnClick:)];
        _customOperationBtn.tag = 3;
    }
    return _customOperationBtn;
}

- (UIButton *)operationBtn {
    if (!_operationBtn) {
        _operationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _operationBtn.frame = CGRectMake(KScreenWidth - 80, KNavAndStatusHeight, 80, 40);
        _operationBtn.layer.backgroundColor = [[UIColor redColor] CGColor];
        [_operationBtn setTitle:@"NSOperation" forState:UIControlStateNormal];
        _operationBtn.layer.cornerRadius = 4.f;
        [_operationBtn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _operationBtn.tag = 2;
    }
    return _operationBtn;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(0, KNavAndStatusHeight, 80, 40);
        _btn.layer.backgroundColor = [[UIColor greenColor] CGColor];
        _btn.layer.cornerRadius = 4.0f;
        [_btn setTitle:@"Thread" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn.tag = 1;
    }
    return _btn;
}

@end
