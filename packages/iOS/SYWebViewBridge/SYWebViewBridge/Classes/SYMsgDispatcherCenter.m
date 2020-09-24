//
//  SYMsgDispatcherCenter.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYMsgDispatcherCenter.h"
#import "SYBridgeDebugPlugin.h"
#import "SYBridgeLifeCyclePlugin.h"
#import "SYBridgeSystemPlugin.h"
#import "NSInvocation+SYBridge.h"
#import "SYBridgeMessage.h"

@interface SYMsgDispatcherCenter ()
@property (nonatomic, strong) NSMutableDictionary *pluginDict;
@end

@implementation SYMsgDispatcherCenter

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    SYBridgeDebugPlugin *debugPlugin = [[SYBridgeDebugPlugin alloc] init];
    SYBridgeLifeCyclePlugin *lifeCyclePlugin = [[SYBridgeLifeCyclePlugin alloc] init];
    SYBridgeSystemPlugin *systemPlugin = [[SYBridgeSystemPlugin alloc] init];
    _pluginDict = @{
        @"sydebug": debugPlugin,
        @"sylifeCycle": lifeCyclePlugin,
        @"sysystem": systemPlugin
    }.mutableCopy;
}


- (BOOL)dispatchMsg:(SYBridgeMessage *)msg callback:(SYPluginMsgCallBack)callback {
    SYBridgeBasePlugin *plugin = _pluginDict[msg.module];
    if (!plugin || ![plugin isKindOfClass:[SYBridgeBasePlugin class]]) {
        return NO;
    }
    BOOL ret = [plugin invoke:msg callback:callback];
    return ret;
}

@end
