//
//  SYBridgeMessage.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import <Foundation/Foundation.h>

@interface SYBridgeMessage : NSObject

- (instancetype)initWithRouter:(NSString *)router;

@property (nonatomic, copy) NSString *router;

@property (nonatomic, copy) NSString *scheme;
@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, copy) NSString *module;
@property (nonatomic, copy) NSString *action;
@property (nonatomic, copy) NSString *jsCallBack;

@property (nonatomic, strong) NSDictionary *paramDict;
@property (nonatomic, strong) NSDictionary *extInfo;

@end
