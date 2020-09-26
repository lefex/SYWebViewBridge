//
//  SYConstant.h
//  Pods
//
//  Created by SuYan Wang on 2020/9/5.
//

#ifndef SYConstant_h
#define SYConstant_h

@class SYBridgeMessage;

// the common messge handler for window.webkit.messageHandlers.xxx.postMessage
static NSString *kSYScriptMsgName = @"SYJSBridge";
// the environment messge handler for window.webkit.messageHandlers.xxx.postMessage
static NSString *kSYScriptEnvMsgName = @"SYJSBridgeEnv";
// the default js callback
static NSString *kSYDefaultCallback = @"core.sendCallback";
// the default namespcae
static NSString *kSYDefaultNameSpace = @"sy";
// the default scheme
static NSString *kSYDefaultScheme = @"suyan";
// the unique id, can use app bundle id
static NSString *kSYDefaultIdentifier = @"com.sy.bridge";
// the webview bridge receive message function
static NSString *kSYDefaultWebViewBridgeMsg = @"syBridgeMessage";



typedef void(^SYPluginMsgCallBack)(NSDictionary *info, SYBridgeMessage *msg);

#endif /* SYConstant_h */
