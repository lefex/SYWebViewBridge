//
//  SYHybridWebView.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/5.
//

#import <WebKit/WebKit.h>
#import "SYConstant.h"

NS_ASSUME_NONNULL_BEGIN

@class SYBridgeMessage;
@class SYBridgeBasePlugin;

// the webview can send message between app and web page
@interface SYHybridWebView : WKWebView

// webview source url to load web page
@property (nonatomic, copy) NSString *sourceUrl;
// router scheme, default is suyan
@property (nonatomic, copy, nullable) NSString *scheme;
// router identifier, you can use app bundle id, such as com.sy.fe
@property (nonatomic, copy, nullable) NSString *identifier;
// retry load web content when terminate action
@property (nonatomic, assign) BOOL retryWhenTerminate;
// check router is valid
@property (nonatomic, copy, nullable) SYCheckRouteBlock routerIsValidBlock;

// reload webview
- (void)syReload;

/// send message to webview
/// @param msg the message that will send
/// @param handler callback
- (void)sySendMessage:(SYBridgeMessage *)msg
    completionHandler:(void(^)(id msg, NSError *error))handler;

/// reginter a plugin to deal with message when receive from web page
/// @param plugin a plugin must subclass of SYBridgeBasePlugin
/// @param moduleName the module name to help find which module to deal with message
- (BOOL)syRegisterPlugin:(SYBridgeBasePlugin *)plugin
           forModuleName:(NSString *)moduleName;


@end

NS_ASSUME_NONNULL_END
