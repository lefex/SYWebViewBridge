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
@property (nonatomic, assign) NSInteger retryCount;
@end

@implementation SYHybridWebView

#pragma mark - Init
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
            // TODO: no use, if you have problem, give me an issue
        }];
    };
    // deal with environment message
    [self.configuration.userContentController addScriptMessageHandler:self name:kSYScriptEnvMsgName];
    // deal with common message
    [self.configuration.userContentController addScriptMessageHandler:self.msgHandler name:kSYScriptMsgName];
}

#pragma mark public method
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
    [self evaluateJavaScript:jsCode completionHandler:handler];
}

- (BOOL)syRegisterPlugin:(SYBridgeBasePlugin *)plugin forModuleName:(NSString *)moduleName {
    return [self.msgHandler registerPlugin:plugin forModuleName:moduleName];
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
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIViewController *rootVC = [window rootViewController];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // click ok
    }]];
    [rootVC presentViewController:alert animated:YES completion:nil];
    completionHandler();
}

#pragma mark - WKNavigationDelegate
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    if (_retryWhenTerminate && _retryCount <= 0) {
        [self syReload];
        _retryCount += 1;
    }
}

@end
