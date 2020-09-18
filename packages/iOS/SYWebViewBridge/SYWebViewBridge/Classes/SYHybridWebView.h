//
//  SYHybridWebView.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/5.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYHybridWebView : WKWebView

@property (nonatomic, copy) NSString *sourceUrl;

- (void)syReload;

- (void)syEvaluateJS:(NSString *)jsCode completionHandler:(void(^)(id msg, NSError *error))handler;

- (void)syAddScript:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
