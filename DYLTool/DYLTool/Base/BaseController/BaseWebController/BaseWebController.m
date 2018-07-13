//
//  TGViewController.m
//  CustomerView
//
//  Created by sky on 2018/6/7.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "BaseWebController.h"
// 通过代理对象打破循环引用
@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>) scripageDelegate;

@end

@implementation WeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scripageDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scripageDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end

@interface BaseWebController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic,strong) WKWebView *wkWebView;  //  WKWebView
@property (nonatomic,strong) UIRefreshControl *refreshControl;  //刷新
@property (nonatomic,strong) UIProgressView *progress;  //进度条
@property (nonatomic,strong) UIButton *reloadBtn;  //重新加载按钮

@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;   //返回按钮
@property (nonatomic, strong) UIBarButtonItem *closeBarButtonItem;  //关闭按钮

@end

@implementation BaseWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadRequest];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _wkWebView.UIDelegate = nil;
    _wkWebView.navigationDelegate = nil;
    [_wkWebView stopLoading];
}

#pragma mark WKScriptMessageHandler js 拦截 调用OC方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if([message.name isEqualToString:@"定义的标识符"]) {
        if ([message.body isEqualToString:@""]) {
            // TODO do some thing
        }
    }
}
#pragma mark Dealloc
- (void)dealloc {
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self clearCache];
}

#pragma mark --- 清楚缓存 ----
- (void)clearCache {
    // 获取library文件夹位置
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    // 获取boundle ID
    NSString *boundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    // 拼接缓存地址 具体目录为 App/Library/Caches/你的APPBundleID/fsCachedData
    NSString *webKitFolderInCachesfs = [NSString stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,boundleID];
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 取得目录下所有的文件, 取得文件数组
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:webKitFolderInCachesfs error:&error];
    for (NSString *fileName in fileList) {
        NSString *path = [[NSBundle bundleWithPath:webKitFolderInCachesfs] pathForResource:fileName ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data.length > 2) {
            int char1 = 0;
            int char2 = 0;
            [data getBytes:&char1 range:NSMakeRange(0, 1)];
            [data getBytes:&char2 range:NSMakeRange(1, 1)];
            
            NSString *numStr = [NSString stringWithFormat:@"%i%i", char1, char2];
            // 如果该文件的前四个字符是6033, 说明是html文件,删除掉本地缓存
            if ([numStr isEqualToString:@"6033"]) {
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", webKitFolderInCachesfs, fileName] error:&error];
            }
        }
    }
}


#pragma mark UIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {}

#pragma mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    _progress.hidden = NO;
    _wkWebView.hidden = NO;
    _reloadBtn.hidden = YES;
    // 看是否加载空网页
    if ([webView.URL.scheme isEqual:@"about"]) {
        webView.hidden = YES;
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //执行JS方法获取导航栏标题
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        self.navigationItem.title = title;
    }];
    [self showLeftBarButtonItem];
    [_refreshControl endRefreshing];
}

// 返回内容是否允许加载
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    webView.hidden = YES;
    _reloadBtn.hidden = NO;
}


#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        _progress.progress = [change[@"new"] floatValue];
        if (_progress.progress == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _progress.hidden = YES;
            });
        }
    }
}

#pragma mark 导航按钮
- (void)back:(UIBarButtonItem*)item {
    if ([_wkWebView canGoBack]) {
        [_wkWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)close:(UIBarButtonItem*)item {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark private Methods
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self showLeftBarButtonItem];
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progress];
    [self.view addSubview:self.reloadBtn];
}

- (void)loadRequest {
    if (![self.urlString hasPrefix:@"http"]) {//容错处理 不要忘记plist文件中设置http可访问 App Transport Security Settings
        self.urlString = [NSString stringWithFormat:@"http://%@",self.urlString];
    }
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString]];
    [_wkWebView loadRequest:request];
}

- (void)wkWebViewReload {
    [_wkWebView reload];
}

- (void)showLeftBarButtonItem {
    if ([_wkWebView canGoBack]) {
        self.navigationItem.leftBarButtonItems = @[self.backBarButtonItem,self.closeBarButtonItem];
    } else {
        self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    }
}

#pragma mark lazy load
- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        // 设置WKWebView基本配置信息
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.preferences = [[WKPreferences alloc] init];
        configuration.allowsInlineMediaPlayback = YES;
        configuration.selectionGranularity = YES;
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"定义的标识符"];
        
        if (_jsString) {
            WKUserScript *jsString = [[WKUserScript alloc] initWithSource:_jsString injectionTime:(WKUserScriptInjectionTimeAtDocumentStart) forMainFrameOnly:NO];
            [userContentController addUserScript:jsString];
        }
        configuration.userContentController = userContentController;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        // 设置代理
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        // 是否开启下拉刷新
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0 && _canDownRefresh) {
            _wkWebView.scrollView.refreshControl = self.refreshControl;
        }
        // 添加进度监听
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return _wkWebView;
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(wkWebViewReload) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

- (UIProgressView* )progress {
    if (!_progress) {
        _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 2)];
        _progress.progressTintColor = _loadingProgressColor?_loadingProgressColor:[UIColor greenColor];
    }
    return _progress;
}

- (UIButton *)reloadBtn {
    if (!_reloadBtn) {
        _reloadBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _reloadBtn.frame = CGRectMake(0, 0, 200, 140);
        _reloadBtn.center = self.view.center;
        [_reloadBtn setBackgroundImage:[UIImage imageNamed:@"loadingError"] forState:UIControlStateNormal];
        [_reloadBtn setTitle:@"网络异常，点击重新加载" forState:UIControlStateNormal];
        [_reloadBtn addTarget:self action:@selector(wkWebViewReload) forControlEvents:UIControlEventTouchUpInside];
        [_reloadBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _reloadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_reloadBtn setTitleEdgeInsets:UIEdgeInsetsMake(200, -50, 0, -50)];
        _reloadBtn.titleLabel.numberOfLines = 0;
        _reloadBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        CGRect rect = _reloadBtn.frame;
        rect.origin.y -= 100;
        _reloadBtn.frame = rect;
        _reloadBtn.hidden = YES;
    }
    return _reloadBtn;
}

- (UIBarButtonItem *)backBarButtonItem {
    if (!_backBarButtonItem) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"barbuttonicon_back_15x30"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _backBarButtonItem;
}

- (UIBarButtonItem *)closeBarButtonItem {
    if (!_closeBarButtonItem) {
        _closeBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    }
    return _closeBarButtonItem;
}

@end
