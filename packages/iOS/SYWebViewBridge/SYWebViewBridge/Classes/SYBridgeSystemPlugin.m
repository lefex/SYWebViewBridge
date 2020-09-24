//
//  SYBridgeSystemPlugin.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeSystemPlugin.h"
#import "SYBridgeMessage.h"

@implementation SYBridgeSystemPlugin

- (BOOL)invoke:(SYBridgeMessage *)msg callback:(SYPluginMsgCallBack)callback {
    BOOL isValid = [super invoke:msg callback:callback];
    if (isValid) {
        [self showModal:msg callback:callback];
    }
    return YES;
}

- (void)showModal:(SYBridgeMessage *)msg callback:(SYPluginMsgCallBack)callback {
    NSString *title = @"SYBridge debug";
    if (msg.paramDict[@"title"]) {
        title = msg.paramDict[@"title"];
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg.paramDict[@"content"] preferredStyle:UIAlertControllerStyleAlert];
    if ([msg.paramDict[@"showCancel"] boolValue]) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:msg.paramDict[@"cancelText"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (callback) {
                callback(@{
                    @"cbtype": @"success",
                    @"confirm": @(0)
                }, msg);
            }
        }];
        [alert addAction:cancelAction];
    }
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:msg.paramDict[@"confirmText"] ?: @"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (callback) {
            callback(@{
                @"cbtype": @"success",
                @"confirm": @(1)
            }, msg);
        }
    }];
    [alert addAction:okAction];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
