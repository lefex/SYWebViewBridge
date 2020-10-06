//
//  SYBridgeMessage.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import <Foundation/Foundation.h>

@interface SYBridgeMessage : NSObject

// the router must valid
// suyan://com.sy.bridge/debug/showAlert?params={key: value}&callback=js_callback
- (instancetype)initWithRouter:(NSString *)router;

@property (nonatomic, copy) NSString *router;
// router scheme
@property (nonatomic, copy) NSString *scheme;
// router identifier
@property (nonatomic, copy) NSString *identifier;
// module name to find plugin
@property (nonatomic, copy) NSString *moduleName;
// method name
@property (nonatomic, copy) NSString *action;
// params of method
@property (nonatomic, strong) NSDictionary *paramDict;
// router query
@property (nonatomic, strong) NSDictionary *extInfo;
// javscript code will excute in webview
@property (nonatomic, copy) NSString *jsCallBack;

// message must have module and action
- (BOOL)isValidMessage;

@end
