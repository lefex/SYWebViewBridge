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
#import "SYWeakProxy.h"

@interface SYHybridWebView ()<WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) SYMessageHandler *msgHandler;
// the bridge object name in window
@property (nonatomic, copy) NSString *namespace;
@property (nonatomic, assign) NSInteger retryCount;
@end

@implementation SYHybridWebView

#pragma mark - Init
- (void)dealloc {
    _msgHandler = nil;
}

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
    
    SYMessageHandler *messageHandler = [[SYMessageHandler alloc] init];
    messageHandler.routerIsValidBlock = self.routerIsValidBlock;
    __weak __typeof(self) weakSelf = self;
    messageHandler.actionComplete = ^(NSDictionary * info, SYBridgeMessage *msg) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf excuteCallback:info message:msg];
    };
    messageHandler.handleMessageBlock = ^BOOL(SYBridgeMessage *msg) {
        if ([msg isWebViewMessage]) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSString *selName = [NSString stringWithFormat:@"%@:callback:", msg.action];
            SYPluginMessageCallBack callback = ^(NSDictionary * info, SYBridgeMessage *msg) {
                [strongSelf excuteCallback:info message:msg];
            };
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [strongSelf performSelector:NSSelectorFromString(selName) withObject:msg withObject:callback];
            #pragma clang diagnostic pop;
            return YES;
        }
        return NO;
    };

    [self.configuration.userContentController addScriptMessageHandler:(id <WKScriptMessageHandler>)[SYWeakProxy proxyWithTarget:self.msgHandler] name:kSYScriptMsgName];
    self.msgHandler = messageHandler;
}

- (void)excuteCallback:(NSDictionary *)info message:(SYBridgeMessage *)msg {
    NSMutableDictionary *jsInfoDict = [info mutableCopy];
    jsInfoDict[@"_sycallbackId"] = msg.paramDict[@"_sycallbackId"];
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
    [self syEvaluateJS:jscode completionHandler:^(id  _Nonnull msg, NSError * _Nonnull error) {
        // no use, if you have problem, give me an issue
    }];
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

# pragma mark - handle webview message
- (void)setEnv:(SYBridgeMessage *)msg callback:(SYPluginMessageCallBack)callback {
    // set the webview`s object on the window
    if (msg.paramDict[@"namespace"]) {
        self.namespace = msg.paramDict[@"namespace"];
        if (callback) {
            callback(@{
                kSYCallbackType: kSYCallbackSuccess
            }, msg);
        }
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
