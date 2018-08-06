###  iOS  动画
-----------------------------

- CAAnimation: 核心动画基类(CAPropertyAnimation(属性动画), CAAnimationGroup(动画组), CATransition(转场动画)), 不能直接使用,负责动画运行时间,速度控制,本身实现了CAMediaTiming协议

= CAPropertyAnimation: 属性动画基类(通过属性进行动画设置,注意是可动画属性), 不能直接使用

- CAAnimationGroup: 动画组, 动画组是一种组合模式设计,可以通过动画组来进行动画行为的统一控制,组中所有的动画效果可以并发执行

- CATransition: 转场动画,主要通过滤镜进行动画效果设置

- CABasicAnimation: 基础动画,通过属性修改进行动画参数控制,只有开始状态和结束状态

- CAKeyframeAnimation: 关键帧动画,同样是通过属性进行动画参数控制.但是同基础动画不同的是它可以有多个状态控制

----------------------------

1. 基础动画CABasicAnimation
创建步骤:
①. 初始化动画并设置动画属性
②. 设置动画属性初始值(可省略),结束值以及其他动画属性
③. 给图层添加动画
`
eg:

- (void)translationAnimation:(CGPoint)location {
    // 1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 2. 设置动画属性初始值和结束值
    basicAnimation.fromValue = [NSValue valueWithCGPoint:CGPointZero];
    basicAnimation.toValue = [NSValue valueWithCGPoint:location];
    // 设置其他动画属性
    basicAnimation.delegate = self; // 设置代理
    basicAnimation.duration = 3.0f; // 动画时间
    basicAnimation.repeatCount = HUGE_VALF; // 设置重复次数,HUGE_VALF可看做无穷大
    basicAnimation.removeOnCompletion = NO; // 运行一次后移除动画
    // 3.添加动画图层,注意key相当于给动画进行命名,以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"animation_Name"];
}
`



