//
//  SYMessageHandler.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/5.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "SYConstant.h"

@class SYBridgeBasePlugin;

@interface SYMessageHandler : NSObject<WKScriptMessageHandler>

// the action send a callback
@property (nonatomic, copy) SYPluginMessageCallBack actionComplete;

// check router is valid
@property (nonatomic, copy) SYCheckRouteBlock routerIsValidBlock;

// receive a message
@property (nonatomic, copy) SYHandleMessageBlock handleMessageBlock;

/// register a custom plugin
/// @param plugin the plugin must be subclass SYBridgeBasePlugin
/// @param moduleName the module name, must be unique in plugin system
- (BOOL)registerPlugin:(SYBridgeBasePlugin *)plugin forModuleName:(NSString *)moduleName;

@end
