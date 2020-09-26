//
//  NSObject+SYBridge.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/20.
//

#import "NSObject+SYBridge.h"

@implementation NSObject (SYBridge)

// code from https://github.com/ibireme/YYModel/blob/master/YYModel/NSObject%2BYYModel.m
+ (NSDictionary *)sy_dictionaryWithJSON:(id)json {
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}

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
