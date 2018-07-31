###  iOS 返回按钮那些事
----------------------------------
1. 使用系统返回按钮(隐藏文字),手势滑动返回依然存在

`
UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
self.navigationItem.backBarButtonItem = backItem;
`

2. 自定义返回按钮,手势滑动失效,可以和 FDFullscreenPopGesture 结合实现手势滑动返回, 返回事件需要自己实现

`
UIImage *image = [UIImage imageNamed:@"imgName"];
image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonStyleDone target:target action:action];
[backItem setImageInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
`

