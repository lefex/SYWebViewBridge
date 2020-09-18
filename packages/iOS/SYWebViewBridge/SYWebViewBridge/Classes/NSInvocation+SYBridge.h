//
//  NSInvocation+SYBridge.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSInvocation (SYBridge)

+ (id)sy_invokeInsMethodWithSelName:(NSString *)selName
                           instance:(id)instance
                          arguments:(NSArray *)args;

@end

NS_ASSUME_NONNULL_END
