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

3. iOS 11 系统导航栏自定义View显示问题

`
self.navigationItem.hideBackButton = YES;
[self.navigationController.navigationBar addSubView:yourCustomView];
在控制器dealloc方法中移除自定义View
[yourCustomView removeFromSuperView];
`

4. UITableView 出现遮挡显示问题(放到基类)

`
iOS11适配
self.tableView.estimatedRowHeight = 0;
self.tableView.estimatedSectionHeaderHeight = 0;
self.tableView.estimatedSectionFooterHeight = 0;
`

5. iPhoneX 危险区域: 顶部44 底部34

6. UIScrollView frame 和 contentSize 高度或者宽度一致导致偏移

`
if (@avaliable(iOS11, *)) {
    _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}
如果在push进入webView页面时,底部有黑边一闪而过,也可以用此方法解决,可以在AppDelegate中进行全局设置
if (@avaliable(iOS11, *) {
    [[UIScrollView apperance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustment];
}
`








