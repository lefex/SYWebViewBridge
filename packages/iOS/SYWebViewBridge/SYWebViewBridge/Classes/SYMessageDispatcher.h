//
//  SYMsgDispatcherCenter.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import <Foundation/Foundation.h>
#import "SYConstant.h"

NS_ASSUME_NONNULL_BEGIN

@class SYBridgeBasePlugin;

@interface SYMessageDispatcher : NSObject

/// dispatch message to plugin and get a callback
/// @param msg router message
/// @param callback action callback
/// @return return YES if find the plugin action
- (BOOL)dispatchMessage:(SYBridgeMessage *)msg callback:(SYPluginMessageCallBack)callback;

/// register a custom plugin
/// @param plugin custom plugin instance
/// @param moduleName plugin name, must be unique in plugin system
- (BOOL)setPlugin:(SYBridgeBasePlugin *)plugin forModuleName:(NSString *)moduleName;

@end

NS_ASSUME_NONNULL_END
