//
//  SYBridgeMessage.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/16.
//

#import "SYBridgeMessage.h"

@implementation SYBridgeMessage

- (instancetype)initWithRouter:(NSString *)router {
    self = [super init];
    if (self) {
        _router = router;
        if (router) {
            [self parserRouter:router];
        }
    }
    return self;
}

// suyan://gzh.fe/debug/showAlert?param={key: value}&callback=js_callback
- (void)parserRouter:(NSString *)router {
    NSArray *components = [router componentsSeparatedByString:@"?"];
    if ([components count] == 0 || [components count] > 2) {
        // router invalid
        return;
    }
    NSString *firstPath = [components firstObject];
    NSRange schemeRange = [firstPath rangeOfString:@"://"];
    if (schemeRange.location == NSNotFound) {
        return;
    }
    NSString *scheme = [firstPath substringWithRange:NSMakeRange(0, schemeRange.location)];
    NSString *hostPath = [firstPath substringFromIndex:schemeRange.location + schemeRange.length];
    NSArray *firstComponents = [hostPath componentsSeparatedByString:@"/"];
    if ([firstComponents count] != 3) {
        // router must contain bundleId、module and action
        return;
    }
    self.scheme = scheme;
    self.identifier = firstComponents[0];
    self.module = firstComponents[1];
    self.action = firstComponents[2];
    if ([components count] == 1) {
        // have no params
        return;
    }
    NSString *lastPath = [components lastObject];
    NSArray *lastComponetns = [lastPath componentsSeparatedByString:@"&"];
    __block NSMutableDictionary *extInfo;
    [lastComponetns enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *paths = [obj componentsSeparatedByString:@"="];
        if ([paths count] == 2) {
            if ([(NSString *)[paths firstObject] isEqualToString:@"params"]) {
                NSData *data = [(NSString *)[paths lastObject] dataUsingEncoding:NSUTF8StringEncoding];
                if (data) {
                    NSError *error;
                    NSDictionary *parmDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingFragmentsAllowed error:&error];
                    self.paramDict = parmDict;
                }
            }
            else if ([(NSString *)[paths firstObject] isEqualToString:@"callback"]) {
                self.jsCallBack = [paths lastObject];
            }
            else {
                if (!extInfo) {
                    extInfo = [NSMutableDictionary dictionary];
                    [extInfo setObject:[paths lastObject] forKey:[paths firstObject]];
                }
            }
        }
        
    }];
    self.extInfo = extInfo;
}

@end
