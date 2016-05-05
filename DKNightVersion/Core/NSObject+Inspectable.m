//
//  NSObject+Inspectable.m
//  DKNightVersion
//
//  Created by Draveness on 16/5/5.
//  Copyright © 2016年 Draveness. All rights reserved.
//

#import "NSObject+Inspectable.h"
#import "DKColorTable.h"
#import <objc/runtime.h>

@implementation NSObject (Inspectable)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(awakeFromNib);
        SEL swizzledSelector = @selector(dk_awakeFromNib);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    
}

- (void)dk_awakeFromNib {
    [self dk_awakeFromNib];

    Class class = [self class];

    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(class, &methodCount);

    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];

        const char *method_name = sel_getName(method_getName(method));

        NSString *methodName = [NSString stringWithUTF8String:method_name];

        if ([methodName hasPrefix:@"dk_set"] && [methodName hasSuffix:@"ColorPicker:"]) {
            SEL normalColorGetter = NSSelectorFromString([self normalColorHelper:methodName]);
            SEL nightColorGetter = NSSelectorFromString([self nightColorHelper:methodName]);
            SEL pickerSetter = NSSelectorFromString(methodName);
            UIColor *normalColor = [self performSelector:normalColorGetter];
            UIColor *nightColor = [self performSelector:nightColorGetter];
            if (normalColor && nightColor) {
                [self performSelector:pickerSetter withObject:DKColorPickerWithColors(normalColor, nightColor, normalColor)];
            }
        }

    }
    
    free(methods);
}

- (NSString *)normalColorHelper:(NSString *)string {
    NSString *colorName = [[string stringByReplacingOccurrencesOfString:@"dk_set" withString:@""]
                           stringByReplacingOccurrencesOfString:@"Picker:" withString:@""];
    return [NSString stringWithFormat:@"normal%@", colorName];
}

- (NSString *)nightColorHelper:(NSString *)string {
    NSString *colorName = [[string stringByReplacingOccurrencesOfString:@"dk_set" withString:@""]
                           stringByReplacingOccurrencesOfString:@"Picker:" withString:@""];
    return [NSString stringWithFormat:@"night%@", colorName];
}

@end
