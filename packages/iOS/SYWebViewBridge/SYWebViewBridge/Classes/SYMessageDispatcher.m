//
//  SYMsgDispatcherCenter.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYMessageDispatcher.h"
#import "SYBridgeDebugPlugin.h"
#import "SYBridgeSystemPlugin.h"
#import "SYBridgeMessage.h"

@interface SYMessageDispatcher ()
@property (nonatomic, strong) NSMutableDictionary *pluginDict;
@end

@implementation SYMessageDispatcher

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    SYBridgeDebugPlugin *debugPlugin = [[SYBridgeDebugPlugin alloc] init];
    SYBridgeSystemPlugin *systemPlugin = [[SYBridgeSystemPlugin alloc] init];
    _pluginDict = @{
        @"debug": debugPlugin,
        @"system": systemPlugin
    }.mutableCopy;
}

- (BOOL)setPlugin:(SYBridgeBasePlugin *)plugin forModuleName:(NSString *)moduleName {
    if ([plugin isKindOfClass:[SYBridgeBasePlugin class]] && moduleName.length > 0) {
        [_pluginDict setObject:plugin forKey:moduleName];
        return YES;
    }
    return NO;
}

- (BOOL)dispatchMessage:(SYBridgeMessage *)msg
               callback:(SYPluginMessageCallBack)callback {
    if (!msg.moduleName || msg.moduleName.length <= 0) {
        return NO;
    }
    SYBridgeBasePlugin *plugin = _pluginDict[msg.moduleName];
    if (!plugin || ![plugin isKindOfClass:[SYBridgeBasePlugin class]]) {
        return NO;
    }
    BOOL ret = [plugin invoke:msg callback:callback];
    return ret;
}

@end
