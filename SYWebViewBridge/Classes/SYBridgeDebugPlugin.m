//
//  SYBridgeDebugPlugin.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeDebugPlugin.h"

@implementation SYBridgeDebugPlugin

- (void)alert:(SYBridgeMessage *)msg {
    NSString *title = @"SYBridge debug";
    if (msg.paramDict[@"title"]) {
        title = msg.paramDict[@"title"];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg.paramDict[@"content"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)log:(SYBridgeMessage *)msg {
    NSString *logMsg = msg.paramDict[@"msg"];
    if ([NSJSONSerialization isValidJSONObject:logMsg]) {
        NSData *data = [logMsg dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            logMsg = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        }
    }
    NSLog(@"[SYBridge] - %@", logMsg);
}

@end
