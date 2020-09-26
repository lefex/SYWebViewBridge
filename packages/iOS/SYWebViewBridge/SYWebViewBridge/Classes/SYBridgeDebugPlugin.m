//
//  SYBridgeDebugPlugin.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeDebugPlugin.h"

@implementation SYBridgeDebugPlugin

- (void)alert:(SYBridgeMessage *)msg callback:(SYPluginMsgCallBack)callback {
    NSString *title = @"SYBridge debug";
    if (msg.paramDict[@"title"]) {
        title = msg.paramDict[@"title"];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg.paramDict[@"content"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alert show];
}

- (void)log:(SYBridgeMessage *)msg {
    NSString *logMsg = msg.paramDict[@"msg"];
    NSLog(@"[SYBridge] - %@", logMsg);
}

@end
