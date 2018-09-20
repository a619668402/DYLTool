//
//  Person.m
//  DYLTool
//
//  Created by sky on 2018/8/28.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "Person.h"

@interface Person ()

//@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) Student *student;

@end

@implementation Person

//- (void)setName:(NSString *)name {
//    _name = name;
//    KLogFunc;
//}

- (instancetype)init {
    if (self = [super init]) {
        self.student = [Student new];
        [self addObserver:self forKeyPath:@"testArray" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"change = %@", change);
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"testArray"];
}

- (NSString *)getname {
//    return _name;
    return nil;
}

- (NSString *)getname1 {
    return name;
}

+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (id)valueForUndefinedKey:(NSString *)key {
    KLog(@"this is a error");
    return nil;
}

- (void)addItem {
    [self.testArray addObject:@"addItem"];
}

- (void)removeItem {
    [self.testArray removeObject:@"addItem"];
}

- (void)addItemObserver {
    [[self mutableArrayValueForKey:@"testArray"] addObject:@"dsfd"];
}

- (void)removeItemObserver {
    [[self mutableArrayValueForKey:@"testArray"] removeObjectAtIndex:0];
}

@end
