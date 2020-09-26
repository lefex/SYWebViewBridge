//
//  SYMessageHandler.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/5.
//

#import "SYMessageHandler.h"
#import "SYConstant.h"
#import "SYBridgeMessage.h"
#import "SYMsgDispatcherCenter.h"

@interface SYMessageHandler ()
@property (nonatomic, strong) SYMsgDispatcherCenter *dispatcher;
@end

@implementation SYMessageHandler

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
}

- (SYMsgDispatcherCenter *)dispatcher {
    if (!_dispatcher) {
        _dispatcher = [[SYMsgDispatcherCenter alloc] init];
    }
    return _dispatcher;
}
/*
 suyan://com.sy.bridge/debug:submodule/showAlert?param={key: value}&callback=js_callback
 [scheme]://[bundle id] / [module] / [action] ? [参数] & [回调函数]
 **/

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
//    window.webkit.messageHandlers.JSBridge.postMessage({"name" : "Lefe_x"});
//    当在一个网页中调用 window.webkit.messageHandlers.[xxx].postMessage 时，客户端会在这个方法中接收消息
    NSLog(@"userContentController: body=%@, name: %@", message.body, message.name);
    
    
    if ([message.body isKindOfClass:[NSString class]]) {
        if ([message.name isEqualToString:kSYScriptMsgName]) {
            // 保存图片
            NSString *router = message.body;
            SYBridgeMessage *syMsg = [[SYBridgeMessage alloc] initWithRouter:router];
            if (!syMsg) {
                return;
            }
            [self.dispatcher dispatchMsg:syMsg callback:self.actionComplete];
            NSLog(@"reveive msg: %@", router);
        }
    }
}

@end
