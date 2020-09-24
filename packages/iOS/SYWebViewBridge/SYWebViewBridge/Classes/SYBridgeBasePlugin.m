//
//  SYBridgeBasePlugin.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeBasePlugin.h"

@implementation SYBridgeBasePlugin

- (BOOL)invoke:(SYBridgeMessage *)msg callback:(SYPluginMsgCallBack)callback; {
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@:callback:", msg.action]);
    if ([self respondsToSelector:sel]) {
        return YES;
    }
    NSLog(@"have no bridge method");
    // subclass must implement
    return NO;
}

@end
