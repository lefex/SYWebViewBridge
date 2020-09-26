//
//  SYHybridWebView.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/5.
//

#import "SYHybridWebView.h"
#import "SYMessageHandler.h"
#import "SYConstant.h"
#import "SYBridgeMessage.h"
#import "NSObject+SYBridge.h"

@interface SYHybridWebView ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) SYMessageHandler *msgHandler;
@property (nonatomic, copy) NSString *namespace;
@end

@implementation SYHybridWebView

- (instancetype)initWithFrame:(CGRect)frame {
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
    // the default namespace is sy in webview window
    self.namespace = kSYDefaultNameSpace;
    // set default scheme
    self.scheme = kSYDefaultScheme;
    // set unique id, can use app bundle id
    self.identifier = kSYDefaultIdentifier;
    self.configuration.preferences = [WKPreferences new];
    self.navigationDelegate = self;
    self.UIDelegate = self;
    self.msgHandler = [[SYMessageHandler alloc] init];
    __weak __typeof(self) weakSelf = self;
    self.msgHandler.actionComplete = ^(NSDictionary * info, SYBridgeMessage *msg) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSMutableDictionary *jsInfoDict = [info mutableCopy];
        jsInfoDict[@"callbackId"] = msg.paramDict[@"callbackId"];
        NSString *jsonInfo = [NSObject sy_dicionaryToJson:jsInfoDict];
        NSString *jscode;
        if (msg.jsCallBack) { // contain callback function
            jscode = [NSString stringWithFormat:@"%@(%@)", msg.jsCallBack, jsonInfo];
        }
        else {
            // use default callback function
            // namespace.core.callback(code)
            jscode = [NSString stringWithFormat:@"%@.%@(%@)", self.namespace, kSYDefaultCallback, jsonInfo];
        }
        [strongSelf syEvaluateJS:jscode completionHandler:^(id  _Nonnull msg, NSError * _Nonnull error) {
            NSLog(@"evalute callbakc error: %@", error);
        }];
    };
    [self.configuration.userContentController addScriptMessageHandler:self name:kSYScriptEnvMsgName];
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

- (void)sySendMessage:(SYBridgeMessage *)msg completionHandler:(void(^)(id msg, NSError *error))handler {
    // namespace.core.callback(code)
    NSString *jsCode = [NSString stringWithFormat:@"%@.%@(\"%@\")", self.namespace, kSYDefaultWebViewBridgeMsg, msg.router];
    [self evaluateJavaScript:jsCode completionHandler:^(id msg, NSError *error) {
        
    }];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.body isKindOfClass:[NSString class]]) {
        if ([message.name isEqualToString:kSYScriptEnvMsgName]) {
            NSString *router = message.body;
            SYBridgeMessage *syMsg = [[SYBridgeMessage alloc] initWithRouter:router];
            if (!syMsg) {
                return;
            }
            NSString *selName = [NSString stringWithFormat:@"%@:", syMsg.action];
            if ([self respondsToSelector:NSSelectorFromString(selName)]) {
               #pragma clang diagnostic push
               #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
               [self performSelector:NSSelectorFromString(selName) withObject:syMsg];
               #pragma clang diagnostic pop;
            }
        }
    }
}

- (void)setEnv:(SYBridgeMessage *)msg {
    // set the webview`s object on the window
    if (msg.paramDict[@"namespace"]) {
        self.namespace = msg.paramDict[@"namespace"];
    }
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

// 白屏会触发的逻辑
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {

}

@end
