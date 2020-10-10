//
//  NSObject+SYBridge.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/20.
//

#import "NSObject+SYBridge.h"

@implementation NSObject (SYBridge)

+ (NSString *)sy_dicionaryToJson:(NSDictionary *)dict {
    NSString *jsonString = nil;
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (error) {
            return nil;
        }
    }
    return jsonString;

}

@end
