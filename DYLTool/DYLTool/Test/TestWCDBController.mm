//
//  TestWCDBController.m
//  DYLTool
//
//  Created by sky on 2018/9/5.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestWCDBController.h"
#import "CompanyInfo.h"
#import <WCDB.h>
#import "TestCustomView.h"

@interface TestWCDBController ()

@property (nonatomic, strong)  WCTDatabase *wcdb;

@end

@implementation TestWCDBController

- (void)viewDidLoad {
    [super viewDidLoad];
    KLog(@"TestWCDBViewController---------");
}

- (void)yl_initValues {
    [super yl_initValues];
    [WCTStatistics SetGlobalSQLTrace:^(NSString *sql) {
        KLog(@"---sql = %@---", sql);
    }];
}

- (void)yl_initViews {
    [super yl_initViews];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, KNavAndStatusHeight, 60, 35);
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [addBtn setTitle:@"Add" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.tag = 0x01;
    [addBtn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    UIButton *readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    readBtn.frame = CGRectMake(0, KNavAndStatusHeight + 40, 60, 35);
    readBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [readBtn setTitle:@"Read" forState:UIControlStateNormal];
    [readBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    readBtn.tag = 0x03;
    [readBtn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:readBtn];
    
    UIButton *openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    openBtn.frame = CGRectMake(60 + 20, KNavAndStatusHeight, 60, 35);
    openBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [openBtn setTitle:@"Open" forState:UIControlStateNormal];
    [openBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    openBtn.tag = 0x02;
    [openBtn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openBtn];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(140 + 20, KNavAndStatusHeight, 60, 35);
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    deleteBtn.tag = 0x05;
    [deleteBtn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    createBtn.frame = CGRectMake(60 + 20, KNavAndStatusHeight + 40, 60, 35);
    createBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [createBtn setTitle:@"Create" forState:UIControlStateNormal];
    [createBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    createBtn.tag = 0x04;
    [createBtn addTarget:self action:@selector(_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createBtn];
    
    TestCustomView *testView = [[TestCustomView alloc] initWithFrame:CGRectMake(0, 150, KScreenWidth, 300)];
    testView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:testView];
    [testView setNeedsDisplay];
}

- (void)_btnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 0x01:
        {
            for (int i = 0; i < 100; i ++) {
                CompanyInfo *info = [[CompanyInfo alloc] init];
//                info.companyId = i + 1;
                info.isAutoIncrement = YES;
                info.companyName = KStringWithFormat(@"Luxshare-ICT--%d", i);
                info.companyAddress = KStringWithFormat(@"青皇工业园区--%d", i);
                BOOL flag = [self.wcdb insertObject:info into:@"CompanyInfo"];
                KLog(@"%d", flag);
            }
        }
            break;
        case 0x02:
        {
            NSString *path = [[KFileManager yl_getDocumentPath] stringByAppendingPathComponent:@"company.db"];
            self.wcdb = [[WCTDatabase alloc] initWithPath:path];
            if ([_wcdb canOpen]) {
                KLog(@"open filed");
            }
            if ([_wcdb isOpened]) {
                KLog(@"database is already opened");
            }
            break;
        }
        case 0x03:
        {
            NSArray<CompanyInfo *> *array = [self.wcdb getAllObjectsOfClass:[CompanyInfo class] fromTable:@"CompanyInfo"];
            KLog(@"%@", array);
        }
            break;
        case 4:
        {
            BOOL flag = [_wcdb createTableAndIndexesOfName:@"CompanyInfo" withClass:[CompanyInfo class]];
            if (flag) {
                KLog(@"创建成功");
            } else {
                KLog(@"创建失败");
            }
        }
            break;
        case 5:
        {
            BOOL flag = [self.wcdb deleteObjectsFromTable:@"CompanyInfo" where:CompanyInfo.companyId == 1];
            if (flag) {
                KLog(@"删除成功");
            } else {
                KLog(@"删除失败");
            }
        }
            break;
        default:
            break;
    }
}

- (void)testBreakPoint {
    KLog(@"-----");
}

@end
