//
//  ViewController.h
//  OpenGLES  01
//
//  Created by ShiWen on 2017/5/4.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

//GLKViewController继承自UIViewController 会自动地重新设置OpenGLES和应用GLKView实例以影响设备房乡变化可视过渡效果
@interface ViewController : GLKViewController
{
//    保存用于曾芳本例中的顶点的数据的缓存的OpenGLES标识符
    GLuint vertexBufferID;
}
/**
 *  为了简化OpenGLES的很多常用操作 隐藏了OpenGLES各个版本之间的差异，简化代码
 */
@property (nonatomic , strong)GLKBaseEffect *baseEffect;


@end

