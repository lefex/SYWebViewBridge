//
//  SYBridgeDebugPlugin.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeBasePlugin.h"

@class SYBridgeMessage;

NS_ASSUME_NONNULL_BEGIN

@interface SYBridgeDebugPlugin : SYBridgeBasePlugin

- (void)alert:(SYBridgeMessage *)msg;

@end

NS_ASSUME_NONNULL_END
