//
//  Person.h
//  DYLTool
//
//  Created by sky on 2018/8/28.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface Person : NSObject
{
    NSString *name;
//    NSString *_name;
}
//@property (nonatomic, copy, readwrite) NSString *name;

@property (nonatomic, strong, readonly) Student *student;

@property (nonatomic, strong, readonly) NSMutableArray *testArray;

- (NSString *)getname;

- (NSString *)getname1;

- (void)addItem;

- (void)removeItem;

- (void)addItemObserver;

- (void)removeItemObserver;

@end
