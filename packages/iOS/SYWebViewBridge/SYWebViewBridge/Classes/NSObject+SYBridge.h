//
//  NSObject+SYBridge.h
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SYBridge)

+ (NSDictionary *)sy_dictionaryWithJSON:(id)json;
+ (NSString *)sy_dicionaryToJson:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
