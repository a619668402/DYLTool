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

@property (nonatomic, assign) GLuint shaderProgram;

@end

@implementation TestOpenGLESController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self yl_initValues];
}

- (void)yl_initValues {
    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!self.mContext) {
        KLog(@"failed to create ES Context");
    }
    GLKView *view = (GLKView *)self.view;
    view.context = self.mContext;
    view.drawableColorFormat = GLKViewDrawableDepthFormat24;
    [EAGLContext setCurrentContext:self.mContext];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
//    glClearColor(1, 0.2, 0.2, 1);
//    glClear(GL_COLOR_BUFFER_BIT);
    // 使用fragment.glsl 和 vertex.glsl中的shader
    glUseProgram(self.shaderProgram);
    [self drawTriangle];
}

- (void)drawTriangle {
    static GLfloat triangleData[18] = {
        0,      0.5f,  0,  1,  0,  0, // x, y, z, r, g, b,每一行存储一个点的信息，位置和颜色
        -0.5f, -0.5f,  0,  0,  1,  0,
        0.5f,  -0.5f,  0,  0,  0,  1,
    };
    GLuint positionAttribLocation = glGetAttribLocation(self.shaderProgram, "position");
    glEnableVertexAttribArray(positionAttribLocation);
    GLuint colorAttribLocation = glGetAttribLocation(self.shaderProgram, "color");
    glEnableVertexAttribArray(colorAttribLocation);
    
    // 为shader中的position和color赋值
    // glVertexAttribPointer (GLuint indx, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid* ptr)
    // indx: 上面Get到的Location
    // size: 有几个类型为type的数据，比如位置有x,y,z三个GLfloat元素，值就为3
    // type: 一般就是数组里元素数据的类型
    // normalized: 暂时用不上
    // stride: 每一个点包含几个byte，本例中就是6个GLfloat，x,y,z,r,g,b
    // ptr: 数据开始的指针，位置就是从头开始，颜色则跳过3个GLFloat的大小
    glVertexAttribPointer(positionAttribLocation, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), (char *)triangleData);
    glVertexAttribPointer(colorAttribLocation, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), (char *)triangleData + 3 * sizeof(GLfloat));
    
    glDrawArrays(GL_TRIANGLES, 0, 3);
}

@end
