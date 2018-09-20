//
//  TestOpenGLESController.m
//  DYLTool
//
//  Created by sky on 2018/9/11.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestOpenGLESController.h"

@interface TestOpenGLESController ()

@property (nonatomic, strong) EAGLContext *mContext;

@end

@implementation TestOpenGLESController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self yl_initValues];
}

- (void)yl_initValues {
    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView *view = (GLKView *)self.view;
    view.context = self.mContext;
    view.drawableColorFormat = GLKViewDrawableColorFormatSRGBA8888;
    [EAGLContext setCurrentContext:self.mContext];
    
    glEnable(GL_DEPTH_TEST);
    glClearColor(0.1, 0.2, 0.3, 1);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

@end
