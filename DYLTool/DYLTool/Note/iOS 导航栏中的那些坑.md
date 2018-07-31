####  iOS 导航栏中的那些坑
----------------------------------------
- 导航栏透明 (如果导航栏不透明,View会向下偏移(导航栏高度 + 状态栏高度))
`
self.navigationController.navigationBar.translucent = YES;
`
- 导航控制器中第一个子控件是ScrollView子类,页面会偏移(导航栏高度 + 状态栏高度)

- 解决导航控制器向下偏移:
1. 设置navigationBar透明

`
self.navigationController.navigationBar.translucent = YES;
`
2. 在ScrollView之前添加一个View

`
UIView *view = [[UIView alloc] initWithFrame:CGrectMake(0, 0, ScreenWidth, 0.01)];
[self.view addSubview:view];
[self.view addSubview:self.scrollView];
`





