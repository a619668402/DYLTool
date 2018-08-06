//
//  TestCustomOperation.h
//  DYLTool
//
//  Created by sky on 2018/8/2.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestCustomOperation : NSOperation

@property (nonatomic, assign, getter=isExecuting) BOOL executing;

@property (nonatomic, assign, getter=isFinished) BOOL finished;

@end
