//
//  SYMessageHandler.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/5.
//

#import "SYMessageHandler.h"
#import "SYConstant.h"
#import "SYBridgeMessage.h"
#import "SYMessageDispatcher.h"
#import "SYBridgeBasePlugin.h"

@interface SYMessageHandler ()
// the class to dispatch event through plugin
@property (nonatomic, strong) SYMessageDispatcher *dispatcher;
@end

@implementation SYMessageHandler

- (BOOL)registerPlugin:(SYBridgeBasePlugin *)plugin forModuleName:(NSString *)moduleName {
    if (!plugin || !moduleName) {
        return NO;
    }
    return [self.dispatcher setPlugin:plugin forModuleName:moduleName];
}

- (SYMessageDispatcher *)dispatcher {
    if (!_dispatcher) {
        _dispatcher = [[SYMessageDispatcher alloc] init];
    }
    return _dispatcher;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.body isKindOfClass:[NSString class]]) {
        // only support router that must a string
        if ([message.name isEqualToString:kSYScriptMsgName]) {
            /*
             router like below:
             suyan://com.sy.bridge/debug:submodule/showAlert?params={key: value}&callback=js_callback
             [scheme]://[bundle id] / [module] / [action] ? [param] & [callback] & [other param]
             */
            NSString *router = message.body;
            
            if (self.routerIsValidBlock) {
                // can not deal with router
                if (!self.routerIsValidBlock(router)) {
                    return;;
                }
            }
            SYBridgeMessage *syMsg = [[SYBridgeMessage alloc] initWithRouter:router];
            // router is invalid
            if (!syMsg || ![syMsg isValidMessage]) {
                return;
            }
            // dispatch message to plugin
            [self.dispatcher dispatchMessage:syMsg callback:self.actionComplete];
        }
    }
}

@end
