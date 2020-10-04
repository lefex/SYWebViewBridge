//
//  SYMessageHandler.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/5.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "SYConstant.h"

@class SYBridgeMessage;
@class SYBridgeBasePlugin;

@interface SYMessageHandler : NSObject<WKScriptMessageHandler>

@property (nonatomic, copy) SYPluginMsgCallBack actionComplete;

- (void)registerPlugin:(SYBridgeBasePlugin *)plugin forModuleName:(NSString *)moduleName;

@end
