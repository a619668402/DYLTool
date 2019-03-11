//
//  TestPlayerView.m
//  DYLTool
//
//  Created by sky on 2019/3/5.
//  Copyright © 2019年 DYL. All rights reserved.
//

#import "TestPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@implementation TestPlayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

@end
