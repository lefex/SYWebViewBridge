//
//  SYBridgeBasePlugin.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeBasePlugin.h"
#import "SYBridgeMessage.h"

@implementation SYBridgeBasePlugin

- (BOOL)invoke:(SYBridgeMessage *)msg {
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@:", msg.action]);
    if ([self respondsToSelector:sel]) {
        return YES;
    }
    // subclass must implement
    return NO;
}

@end
