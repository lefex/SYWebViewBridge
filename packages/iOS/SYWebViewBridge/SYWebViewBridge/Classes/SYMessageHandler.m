//
//  SYMessageHandler.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/5.
//

#import "SYMessageHandler.h"
#import "SYConstant.h"

@implementation SYMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
//    window.webkit.messageHandlers.JSBridge.postMessage({"name" : "Lefe_x"});
//    当在一个网页中调用 window.webkit.messageHandlers.[xxx].postMessage 时，客户端会在这个方法中接收消息
    NSLog(@"userContentController: body=%@, name: %@", message.body, message.name);
    
    
    if ([message.body isKindOfClass:[NSString class]]) {
        if ([message.name isEqualToString:kSYScriptMsgName]) {
            // 保存图片
            NSDictionary *msgInfo = [NSJSONSerialization JSONObjectWithData:[message.body dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"reveive msg: %@", msgInfo);
        }
    }
}

@end
