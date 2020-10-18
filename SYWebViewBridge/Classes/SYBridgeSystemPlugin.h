//
//  SYBridgeSystemPlugin.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeBasePlugin.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYBridgeSystemPlugin : SYBridgeBasePlugin

/// show a modal alert
/// @param msg router to message
/// @param callback receive a callback when click ok or cancel button
- (void)showModal:(SYBridgeMessage *)msg callback:(SYPluginMessageCallBack)callback;

@end

NS_ASSUME_NONNULL_END
