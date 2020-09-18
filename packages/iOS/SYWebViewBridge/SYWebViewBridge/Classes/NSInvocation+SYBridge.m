//
//  NSInvocation+SYBridge.m
//  Pods-SYWebViewBridge_Example
//
//  Created by SuYan Wang on 2020/9/18.
//

#import "NSInvocation+SYBridge.h"

#define sy_TYPE_VAL(type) \
do {\
    type val = 0;\
    [self getArgument:&val atIndex:index];\
    return @(val);\
} while(0);

@implementation NSInvocation (SYBridge)

// https://github.com/steipete/Aspects/blob/master/Aspects.m
- (id)sy_argumentAtIndex:(NSInteger)index {
    const char *argType = [self.methodSignature getArgumentTypeAtIndex:index];
    if (strcmp(argType, @encode(id)) == 0) {
        __autoreleasing id returnObj;
        [self getArgument:&returnObj atIndex:index];
        return returnObj;
    }
    else if (strcmp(argType, @encode(SEL)) == 0) {
        SEL selector = 0;
        [self getArgument:&selector atIndex:index];
        return NSStringFromSelector(selector);
    }
    else if (strcmp(argType, @encode(Class)) == 0) {
        __autoreleasing Class theClass = Nil;
        [self getArgument:&theClass atIndex:index];
        return theClass;
    }
    else if (strcmp(argType, @encode(char)) == 0) {
        sy_TYPE_VAL(char);
    }
    else if (strcmp(argType, @encode(int)) == 0) {
        sy_TYPE_VAL(int);
    }
    else if (strcmp(argType, @encode(short)) == 0) {
        sy_TYPE_VAL(short);
    }
    else if (strcmp(argType, @encode(long)) == 0) {
        sy_TYPE_VAL(long);
    }
    else if (strcmp(argType, @encode(long long)) == 0) {
        sy_TYPE_VAL(long long);
    }
    else if (strcmp(argType, @encode(unsigned char)) == 0) {
        sy_TYPE_VAL(unsigned char);
    }
    else if (strcmp(argType, @encode(unsigned int)) == 0) {
        sy_TYPE_VAL(unsigned int);
    }
    else if (strcmp(argType, @encode(unsigned short)) == 0) {
        sy_TYPE_VAL(unsigned short);
    }
    else if (strcmp(argType, @encode(unsigned long)) == 0) {
        sy_TYPE_VAL(unsigned long);
    }
    else if (strcmp(argType, @encode(unsigned long long)) == 0) {
        sy_TYPE_VAL(unsigned long long);
    }
    else if (strcmp(argType, @encode(float)) == 0) {
        sy_TYPE_VAL(float);
    }
    else if (strcmp(argType, @encode(double)) == 0) {
        sy_TYPE_VAL(double);
    }
    else if (strcmp(argType, @encode(BOOL)) == 0) {
        sy_TYPE_VAL(BOOL);
    }
    else if (strcmp(argType, @encode(bool)) == 0) {
        sy_TYPE_VAL(bool);
    }
    else if (strcmp(argType, @encode(char *)) == 0) {
        sy_TYPE_VAL(const char *);
    }
    // block @?
    else if (strcmp(argType, @encode(void (^)(void))) == 0) {
        __unsafe_unretained id block = nil;
        [self getArgument:&block atIndex:(NSInteger)index];
        return [block copy];
    }
    else {
        NSUInteger valueSize = 0;
        NSGetSizeAndAlignment(argType, &valueSize, NULL);

        unsigned char valueBytes[valueSize];
        [self getArgument:valueBytes atIndex:(NSInteger)index];

        return [NSValue valueWithBytes:valueBytes objCType:argType];
    }
    return nil;
}

- (void)sy_setArgumentAtIndex:(const char *)argType arg:(id)arg index:(NSInteger)i {
    if (strcmp(argType, @encode(id)) == 0) {
        [self setArgument:&arg atIndex:i];
    }
    else if (strcmp(argType, @encode(Class)) == 0) {
        Class value = [arg class];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(SEL)) == 0) {
        SEL value = [arg pointerValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(char)) == 0) {
        char value = [arg charValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(int)) == 0) {
        int value = [arg intValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(short)) == 0) {
        short value = [arg shortValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(long)) == 0) {
        long value = [arg longValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(long long)) == 0) {
        long long value = [arg longLongValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(unsigned char)) == 0) {
        unsigned char value = [arg unsignedCharValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(unsigned int)) == 0) {
        unsigned int value = [arg unsignedIntValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(unsigned short)) == 0) {
        unsigned short value = [arg unsignedShortValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(unsigned long)) == 0) {
        unsigned long value = [arg unsignedLongValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(unsigned long long)) == 0) {
        unsigned long long value = [arg unsignedLongLongValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(float)) == 0) {
        float value = [arg floatValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(double)) == 0) {
        double value = [arg doubleValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(BOOL)) == 0) {
        BOOL value = [arg boolValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(bool)) == 0) {
        bool value = [arg boolValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(char *)) == 0) {
        const char *value = [arg UTF8String];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(IMP)) == 0) {
        IMP value = [arg pointerValue];
        [self setArgument:&value atIndex:i];
    }
    else if (strcmp(argType, @encode(void (^)(void))) == 0) {

    }
    else {

    }
}

- (id)sy_getReturnValue:(const char *)argType {
    id returnVal;
    if (strcmp(argType, @encode(id)) == 0) { // @
        void *result;
        [self getReturnValue:&result];
        returnVal = (__bridge id)result;
    }
    else if (strcmp(argType, @encode(Class)) == 0) {
        Class value;
        [self getReturnValue:&value];
    }
    else if (strcmp(argType, @encode(SEL)) == 0) {
        SEL value;
        [self getReturnValue:&value];
    }
    else if (strcmp(argType, @encode(char)) == 0) {
        char value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(int)) == 0) {
        int value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(short)) == 0) {
        short value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(long)) == 0) {
        long value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(long long)) == 0) {
        long long value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(unsigned char)) == 0) {
        unsigned char value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(unsigned int)) == 0) {
        unsigned int value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(unsigned short)) == 0) {
        unsigned short value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(unsigned long)) == 0) {
        unsigned long value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(unsigned long long)) == 0) {
        unsigned long long value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(float)) == 0) {
        float value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(double)) == 0) {
        double value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(BOOL)) == 0) {
        BOOL value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(bool)) == 0) {
        bool value;
        [self getReturnValue:&value];
        returnVal = @(value);
    }
    else if (strcmp(argType, @encode(char *)) == 0) {
        const char *value;
        [self getReturnValue:&value];
        returnVal = [NSString stringWithUTF8String:value];
    }
    else if (strcmp(argType, @encode(IMP)) == 0) {
        IMP value;
        [self getReturnValue:&value];
    }
    else if (strcmp(argType, @encode(void (^)(void))) == 0) {

    }
    else {

    }
    return returnVal;
}

+ (id)sy_invokeInsMethodWithSelName:(NSString *)selName instance:(id)instance arguments:(NSArray *)args {
    if (!selName || !instance) {
        return nil;
    }
    Class cls = [instance class];
    NSMethodSignature *sign = [cls methodSignatureForSelector:NSSelectorFromString(selName)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sign];
    // 设置参数
    for (NSInteger i = 0; i < args.count; i++) {
        const char *argType = [sign getArgumentTypeAtIndex:i];
        id arg = args[i];
        [invocation sy_setArgumentAtIndex:argType arg:arg index:i];
    }
    // 设置返回值
    [invocation sy_getReturnValue: [sign methodReturnType]];
    
    return nil;
}
@end
