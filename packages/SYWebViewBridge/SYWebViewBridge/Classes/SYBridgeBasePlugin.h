//
//  SYBridgeBasePlugin.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import <Foundation/Foundation.h>
#import "SYBridgeMessage.h"
#import "SYConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYBridgeBasePlugin : NSObject

/// invoke plugin method
/// @param msg webview message
/// @param callback excute result
- (BOOL)invoke:(SYBridgeMessage *)msg callback:(SYPluginMessageCallBack)callback;

@end

NS_ASSUME_NONNULL_END

