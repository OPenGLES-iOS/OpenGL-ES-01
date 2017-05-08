//
//  ViewController.m
//  OpenGLES  01
//
//  Created by ShiWen on 2017/5/4.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "ViewController.h"

/*
 实现步骤：
 1、为缓存生成一个独一无二的标识符
 2、为接下来的运算绑定缓存
 3、赋值数据到缓存中
 4、启动
 5、设置指针
 6、绘图
 */
typedef struct {
    GLKVector3 postionCoords;
}Scenevertex;

static const Scenevertex vertices[]={
    {{0.5f,0.5f,0}},//第一象限
    {{-0.5f,0.5f,1}},//第二象限
    {{0.5f,-0.5f,0.0}},//第四象限
    {{-0.5f,-0.5f,0.0}}//第三象限
    
};

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    获取view
    GLKView *view = (GLKView *)self.view;
//    断言，判断view的类型，如果不是，停止下面运行
    NSAssert([view isKindOfClass:[GLKView class]], @"view类型出错");
//  通过 kEAGLRenderingAPIOpenGLES2 实例化上下文
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
//   将view的上下文设置为当前上下文
    [EAGLContext setCurrentContext:view.context];
//    创建GLKBaseEffect
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    
    /**
     设置画笔颜色

     @param x#> red description#>
     @param y#> green description#>
     @param z#> blue description#>
     @param w#> alpha description#>
     */
    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1);
    
    /**
     设置背景色

     @param red#> red description#>
     @param green#> green description#>
     @param blue#> blue description#>
     @param alpha#> alpha description#>
     */
    glClearColor(0.0f, 0.0f, 0.0f, 1);
//    获取bufferID  第一个参数：指定生成标识符缓存数量，第二个参数：指针，指定标识符的内存保存位置
//    此时，一个标识符正在生成，并保存在vertexBufferID实例变量中
    glGenBuffers(1, &vertexBufferID);
//    绑定用于指定的标识符缓存到当前缓存中 （OpenGLES可以绑定不同类型的缓存到OPenGLES的上下稳文中，但是在任意时刻，每种标识符都只能绑定一种类型）
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferID);
    
    /**
     复制应用顶点数据到当前上下文所绑定的缓存中

     @param GL_ARRAY_BUFFER 缓存类型
     @param vertices 数据
     */
    glBufferData(GL_ARRAY_BUFFER, //指定要更新当前上下文中的哪个缓存
                 sizeof(vertices),//指定要复制这个缓存内的字节数量
                 vertices,//要复制的自己字节的内存地址
                 GL_STATIC_DRAW);//提示了缓存在未来运算中将会被怎样使用 GL_STATIC_DRAW表示告诉上下文，缓存数据将会频繁改变，同时提示OpenGlES用不同的方式来处理缓存的存储
    
    
    

}

/**
 每当GLKView实例需要被重绘时，将调用以下方法
 */
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
//    NSLog(@"%@\n%@",view,NSStringFromCGRect(rect));
//    准备要开始绘图
    [self.baseEffect prepareToDraw];
    
    glClear(GL_COLOR_BUFFER_BIT);
//    启动顶点缓存渲染操作(OpenGLES所支持的每种渲染都可以单独使用保存在当前的OPenGLES上下文中的设置来关闭或启用)
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    /**
     告诉OPenGLES定点数据在哪儿，以及怎么解释每个顶点保存的数据

     @param GLKVertexAttribPosition 指示当前绑定的缓存包含每个顶点位置信息
     @param 3 指示每个位置都有三个部分
     @param GL_FLOAT 告诉OPenGLES没个部分都有Float类型的数据
     @param GL_FALSE 告诉OPenGLES小数点固定的数据是否可被改变
     @param Scenevertex 指"步幅"，告诉GPU从一个顶点的内存开始位置转到下个顶点的内存开始位置需要跳过多骚个字节
     最后个参数为NULL，告诉OPenGLES可以从当前绑定的顶点缓存的开始位置方位顶点数据
     */
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Scenevertex), NULL);
//    NSLog(@"%@",[NSThread currentThread]);
//    通过调用该方法，开始绘制 第一个参数告诉GPU怎么处理绑定在顶点缓存内的顶点数据后两个参数分别指定需要处理的第一个顶点位置和顶点数量
    glDrawArrays(GL_TRIANGLES, 0, 3);
}

-(void)viewDidUnload{
    NSLog(@"ViewDidUnload");
    GLKView *view = (GLKView *)self.view;
    [EAGLContext setCurrentContext:view.context];
    if (0 != vertexBufferID) {
        
        /**
         删除buffers
         */
        glDeleteBuffers(1, &vertexBufferID);
        vertexBufferID = 0;
    }
    ((GLKView *)self.view).context = nil;
    [EAGLContext setCurrentContext:nil];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",event);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
