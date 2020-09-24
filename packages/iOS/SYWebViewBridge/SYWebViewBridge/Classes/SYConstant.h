//
//  SYConstant.h
//  Pods
//
//  Created by SuYan Wang on 2020/9/5.
//

#ifndef SYConstant_h
#define SYConstant_h

@class SYBridgeMessage;

static NSString *kSYScriptMsgName = @"SYJSBridge";
static NSString *kSYDefaultCallback = @"sy.core.sendCallback";

typedef void(^SYPluginMsgCallBack)(NSDictionary *info, SYBridgeMessage *msg);

#endif /* SYConstant_h */
