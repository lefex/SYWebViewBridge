//
//  SYBridgeDebugPlugin.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeBasePlugin.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYBridgeDebugPlugin : SYBridgeBasePlugin

- (void)alert:(SYBridgeMessage *)msg callback:(SYPluginMsgCallBack)callback;

@end

NS_ASSUME_NONNULL_END
