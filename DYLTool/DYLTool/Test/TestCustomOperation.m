//
//  TestCustomOperation.m
//  DYLTool
//
//  Created by sky on 2018/8/2.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestCustomOperation.h"

@implementation TestCustomOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (void)main {
    KLog(@"main begin");
    @try {
        BOOL tastIsFinished = NO;
        while (tastIsFinished == NO && [self isCancelled] == NO) {
            sleep(5);
            KLog(@"currendThread = %@", [NSThread currentThread]);
            KLog(@"mainThread = %@", [NSThread mainThread]);
            
            tastIsFinished = YES;
        }
    } @catch (NSException *e) {
        KLog(@"%@", e);
    }
    KLog(@"main end");
}

- (void)start {
    self.executing = YES;
    for (int i = 0; i < 500; i ++) {
        if (self.isCancelled) {
            self.executing = NO;
            self.finished = YES;
            return;
        }
        KLog(@"Task %d %@ Cancel:%d Executing:%d Finished:%d QueueOperationCount:%ld", i, [NSThread currentThread], self.cancelled, self.executing, self.finished, [[NSOperationQueue currentQueue] operationCount]);
        [NSThread sleepForTimeInterval:0.1];
    }
    KLog(@"Task complete");
    self.executing = NO;
    self.finished = YES;
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isExecuting {
    return _executing;
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isFinished {
    return _finished;
}

- (BOOL)isAsynchronous {
    return YES;
}

@end
