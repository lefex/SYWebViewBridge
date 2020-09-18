//
//  SYMsgDispatcherCenter.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import <Foundation/Foundation.h>

@class SYBridgeMessage;

NS_ASSUME_NONNULL_BEGIN

@interface SYMsgDispatcherCenter : NSObject

- (BOOL)dispatchMsg:(SYBridgeMessage *)msg;

@end

NS_ASSUME_NONNULL_END
