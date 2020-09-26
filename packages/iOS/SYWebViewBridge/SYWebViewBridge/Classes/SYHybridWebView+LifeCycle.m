//
//  SYHybridWebView+LifeCycle.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/26.
//

#import "SYHybridWebView+LifeCycle.h"
#import "SYBridgeMessage.h"

static NSString *kSYLifeCycle = @"_lifecycle";

@implementation SYHybridWebView (LifeCycle)

- (void)syOnLoad {
    SYBridgeMessage *msg = [self messageForAction:@"onLoad"];
    [self sySendMessage:msg completionHandler:^(id msg, NSError *error) {
        // the js callback
    }];
}

- (void)syOnShow {
    SYBridgeMessage *msg = [self messageForAction:@"onShow"];
    [self sySendMessage:msg completionHandler:^(id msg, NSError *error) {
        // the js callback
    }];
}

- (void)syOnHide {
    SYBridgeMessage *msg = [self messageForAction:@"onHide"];
    [self sySendMessage:msg completionHandler:^(id msg, NSError *error) {
        // the js callback
    }];
}

- (void)syOnUnload {
    SYBridgeMessage *msg = [self messageForAction:@"onUnload"];
    [self sySendMessage:msg completionHandler:^(id msg, NSError *error) {
        // the js callback
    }];
}

- (SYBridgeMessage *)messageForAction:(NSString *)action {
    SYBridgeMessage *msg = [[SYBridgeMessage alloc] init];
    msg.module = kSYLifeCycle;
    msg.action = action;
    return msg;
}

@end
