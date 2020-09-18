//
//  SYHybridWebView.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/5.
//

#import "SYHybridWebView.h"
#import "SYMessageHandler.h"
#import "SYConstant.h"

@interface SYHybridWebView ()<WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) SYMessageHandler *msgHandler;
@end

@implementation SYHybridWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.configuration.preferences = [WKPreferences new];
    self.navigationDelegate = self;
    self.UIDelegate = self;
    self.msgHandler = [[SYMessageHandler alloc] init];
    [self.configuration.userContentController addScriptMessageHandler:self.msgHandler name:kSYScriptMsgName];
}

- (void)setSourceUrl:(NSString *)sourceUrl {
    if (![_sourceUrl isEqualToString:sourceUrl]) {
        _sourceUrl = sourceUrl;
        [self syReload];
    }
}

- (void)syReload {
    if (!_sourceUrl) {
        return;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_sourceUrl]];
    [self loadRequest:request];
}

- (void)syEvaluateJS:(NSString *)jsCode completionHandler:(void(^)(id msg, NSError *error))handler {
    [self evaluateJavaScript:jsCode completionHandler:handler];
}

- (void)syAddScript:(NSString *)code {
    WKUserScript *script = [[WKUserScript alloc] initWithSource:code injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    [self.configuration.userContentController addUserScript:script];
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{

}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    NSLog(@"runJavaScriptConfirmPanelWithMessage");
    completionHandler(YES);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    NSLog(@"runJavaScriptTextInputPanelWithPrompt");
    completionHandler(@"OC input");
}


#pragma mark - WKNavigationDelegate
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// error
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if ([navigationAction.request.URL.absoluteString containsString:@"suyan"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
