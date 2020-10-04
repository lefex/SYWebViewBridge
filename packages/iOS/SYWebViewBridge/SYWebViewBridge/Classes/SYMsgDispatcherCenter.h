//
//  SYMsgDispatcherCenter.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import <Foundation/Foundation.h>
#import "SYConstant.h"

NS_ASSUME_NONNULL_BEGIN

@class SYBridgeBasePlugin;

@interface SYMsgDispatcherCenter : NSObject

- (BOOL)dispatchMsg:(SYBridgeMessage *)msg callback:(SYPluginMsgCallBack)callback;

- (void)setPlugin:(SYBridgeBasePlugin *)plugin forModuleName:(NSString *)moduleName;

@end

NS_ASSUME_NONNULL_END
