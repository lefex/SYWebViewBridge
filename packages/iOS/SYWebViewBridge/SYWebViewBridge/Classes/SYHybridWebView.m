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
    WKPreferences *perferences = [[WKPreferences alloc] init];
    perferences.javaEnabled = YES;
    self.configuration.preferences = perferences;
    self.navigationDelegate = self;
    self.UIDelegate = self;
    self.msgHandler = [[SYMessageHandler alloc] init];
    [self.configuration.userContentController addScriptMessageHandler:self.msgHandler name:kSYScriptMsgName];
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

@end
