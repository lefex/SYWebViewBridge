//
//  SYHybridWebViewController.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/26.
//

#import "SYHybridWebViewController.h"
#import "SYHybridWebView+LifeCycle.h"

@interface SYHybridWebViewController ()
@property (nonatomic, strong) SYHybridWebView *webview;
@end

@implementation SYHybridWebViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.view addSubview:self.webview];
    }
    return self;
}

#pragma mark - LifeCycle
- (void)dealloc {
    [_webview syOnUnload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.webview syOnShow];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.webview syOnHide];
}

- (void)loadUrl:(NSString *)url {
    self.webview.sourceUrl = url;
}

- (SYHybridWebView *)webview {
    if (!_webview) {
        WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc] init];
        _webview = [[SYHybridWebView alloc] initWithFrame:self.view.bounds configuration:conf];
    }
    return _webview;
}

@end
