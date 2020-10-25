//
//  SYWeakProxy.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/10/25.
//
// From YYWeakProxy

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYWeakProxy : NSProxy

/**
 The proxy target.
 */
@property (nullable, nonatomic, weak, readonly) id target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
- (instancetype)initWithTarget:(id)target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
