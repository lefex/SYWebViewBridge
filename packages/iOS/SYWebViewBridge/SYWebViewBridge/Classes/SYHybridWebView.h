//
//  SYHybridWebView.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/5.
//

#import <WebKit/WebKit.h>

@class SYBridgeMessage;

@interface SYHybridWebView : WKWebView

@property (nonatomic, copy) NSString *sourceUrl;

@property (nonatomic, copy) NSString *scheme;
@property (nonatomic, copy) NSString *identifier;

- (void)syReload;

- (void)sySendMessage:(SYBridgeMessage *)msg
    completionHandler:(void(^)(id msg, NSError *error))handler;


@end
