//
//  SYBridgeBasePlugin.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import <Foundation/Foundation.h>
#import "SYBridgeMessage.h"
#import "SYConstant.h"

@interface SYBridgeBasePlugin : NSObject

- (BOOL)invoke:(SYBridgeMessage *)msg callback:(SYPluginMsgCallBack)callback;

@end

