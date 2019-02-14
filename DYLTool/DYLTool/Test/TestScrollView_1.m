//
//  TestScrollView_1.m
//  DYLTool
//
//  Created by sky on 2018/12/21.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestScrollView_1.h"

@interface TestScrollView_1 ()<UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) UIScrollView *scrollView;

@property (nonatomic, assign, readwrite) NSInteger currentIndex;

@property (nonatomic, strong) UIView *leftView;

@property (nonatomic, strong) UIView *centerView;

@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, strong, readwrite) NSMutableArray *dataSource;

@property (nonatomic, strong, readwrite) dispatch_source_t timer;

@property (nonatomic, strong, readwrite) UIScrollView *scrollView1;

@property (nonatomic, strong, readwrite) UIView *leftRefreshView;

@end

@implementation TestScrollView_1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KNavAndStatusHeight, KScreenWidth, 200)];
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(KScreenWidth * 3, 200);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self _addChildViews];
    self.currentIndex = 1;
    /*
    self.scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.scrollView.yl_bottom + 50, KScreenWidth, 200)];
//    self.scrollView1.pagingEnabled = YES;
    self.scrollView1.scrollEnabled = YES;
    [self.scrollView1 addSubview:self.leftView];
    self.scrollView1.contentSize = CGSizeMake(KScreenWidth + 1, 200);
    [self.view addSubview:self.scrollView1];
    
    self.leftRefreshView = [[UIView alloc] init];
    self.leftRefreshView.yl_height = 200;
    self.leftRefreshView.yl_width = 100;
    self.leftRefreshView.yl_x = - self.leftRefreshView.yl_width;
    self.leftRefreshView.backgroundColor = red_color;
    [self.scrollView1 addSubview:self.leftRefreshView];
    
    uint64_t interval = 3 * NSEC_PER_SEC;
    dispatch_queue_t queue = dispatch_queue_create("one", 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    KWeakSelf(self);
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y + 200) animated:YES];
        });
    });
     */
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    dispatch_resume(self.timer);
}

- (void)_addChildViews {
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
    [self.scrollView addSubview:self.leftView];
  
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth, 0, KScreenWidth, 200)];
    [self.scrollView addSubview:self.centerView];
    
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth * 2, 0, KScreenWidth, 200)];
    [self.scrollView addSubview:self.rightView];
    /*
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
    [self.scrollView addSubview:self.leftView];
    
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, KScreenWidth, 200)];
    [self.scrollView addSubview:self.centerView];
    
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 200 * 2, KScreenWidth, 200)];
    [self.scrollView addSubview:self.rightView];
     */
}

- (void)setScrollViewContentOffsetCenter {
//    [self.scrollView setContentOffset:CGPointMake(0, 200) animated:NO];
    [self.scrollView setContentOffset:CGPointMake(KScreenWidth, 0) animated:NO];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (_currentIndex != currentIndex) {
        _currentIndex = currentIndex;
        NSInteger leftIndex = (currentIndex + self.dataSource.count - 1) % self.dataSource.count;
        NSInteger rightIndex = (currentIndex + 1) % self.dataSource.count;
        self.leftView.backgroundColor = self.dataSource[leftIndex];
        self.centerView.backgroundColor = self.dataSource[currentIndex];
        self.rightView.backgroundColor = self.dataSource[rightIndex];
        [self setScrollViewContentOffsetCenter];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat radio = scrollView.contentOffset.x / 200;
    KLog(@"-----%f", radio);
    
    if (radio < 0.15) {
        CGPoint offset = scrollView.contentOffset;
        if (offset.x > CGRectGetWidth(scrollView.frame)) {
            self.currentIndex = (self.currentIndex + 1) % self.dataSource.count;
        } else if (offset.x < CGRectGetWidth(scrollView.frame)) {
            self.currentIndex = (self.currentIndex - 1 + self.dataSource.count) % self.dataSource.count;
        }
    }
    if (radio > 2.985) {
        CGPoint offset = scrollView.contentOffset;
        if (offset.x > CGRectGetWidth(scrollView.frame)) {
            self.currentIndex = (self.currentIndex + 1) % self.dataSource.count;
        } else if (offset.x < CGRectGetWidth(scrollView.frame)) {
            self.currentIndex = (self.currentIndex - 1 + self.dataSource.count) % self.dataSource.count;
        }
    }
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i < 100; i ++) {
            [_dataSource addObject:[UIColor yl_randomColor]];
        }
    }
    return _dataSource;
}

@end
