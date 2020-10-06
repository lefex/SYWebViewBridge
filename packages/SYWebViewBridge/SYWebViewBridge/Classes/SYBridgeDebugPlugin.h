//
//  SYBridgeDebugPlugin.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeBasePlugin.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYBridgeDebugPlugin : SYBridgeBasePlugin

/// show a debug alert
/// @param msg router to message
- (void)alert:(SYBridgeMessage *)msg;

/// log a message in debug area
/// @param msg router to message
- (void)log:(SYBridgeMessage *)msg;

@end

NS_ASSUME_NONNULL_END
