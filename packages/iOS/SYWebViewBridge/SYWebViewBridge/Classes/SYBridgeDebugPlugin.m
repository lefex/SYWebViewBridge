//
//  SYBridgeDebugPlugin.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeDebugPlugin.h"

@implementation SYBridgeDebugPlugin

- (BOOL)invoke:(SYBridgeMessage *)msg callback:(SYPluginMsgCallBack)callback {
    BOOL isValid = [super invoke:msg callback:callback];
    if (isValid) {
        [self alert:msg callback:callback];
    }
    return YES;
}

- (void)alert:(SYBridgeMessage *)msg callback:(SYPluginMsgCallBack)callback {
    NSString *title = @"SYBridge debug";
    if (msg.paramDict[@"title"]) {
        title = msg.paramDict[@"title"];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg.paramDict[@"content"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alert show];
}

@end
