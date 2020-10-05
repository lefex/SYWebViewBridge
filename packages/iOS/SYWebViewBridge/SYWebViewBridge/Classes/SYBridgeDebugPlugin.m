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
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIViewController *rootVC = [window rootViewController];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg.paramDict[@"content"] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // click ok
    }]];
    [rootVC presentViewController:alert animated:YES completion:nil];
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
