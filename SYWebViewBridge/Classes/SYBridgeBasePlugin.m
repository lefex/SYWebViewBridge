//
//  SYBridgeBasePlugin.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeBasePlugin.h"

@implementation SYBridgeBasePlugin

- (BOOL)invoke:(SYBridgeMessage *)msg callback:(SYPluginMessageCallBack)callback {
    if (![msg isValidMessage]) {
        // the message invalid
        return NO;
    }
    // have a callback function
    NSString *selName = [NSString stringWithFormat:@"%@:callback:", msg.action];
    if ([self respondsToSelector:NSSelectorFromString(selName)]) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(selName) withObject:msg withObject:callback];
        #pragma clang diagnostic pop
        return YES;
    }
    // have no callback
    selName = [NSString stringWithFormat:@"%@:", msg.action];
    if ([self respondsToSelector:NSSelectorFromString(selName)]) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(selName) withObject:msg];
        #pragma clang diagnostic pop
        return YES;
    }
    return NO;
}

@end
