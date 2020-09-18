//
//  SYBridgeDebugPlugin.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeDebugPlugin.h"
#import "SYBridgeMessage.h"

@implementation SYBridgeDebugPlugin

- (BOOL)invoke:(SYBridgeMessage *)msg {
    BOOL isValid = [super invoke:msg];
    if (isValid) {
        [self alert:msg];
    }
    return YES;
}

- (void)alert:(SYBridgeMessage *)msg {
    NSString *title = @"SYBridge debug";
    if (msg.paramDict[@"title"]) {
        title = msg.paramDict[@"title"];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg.paramDict[@"content"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alert show];
}

@end
