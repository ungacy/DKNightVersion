//
//  CALayer+Night.m
//  NNNightNight
//
//  Created by Draveness on 16/1/29.
//  Copyright © 2016年 DeltaX. All rights reserved.
//

#import "CALayer+Night.h"
#import <objc/runtime.h>

@interface CALayer ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NNColorPicker> *pickers;

@end

@implementation CALayer (Night)

- (NNColorPicker)dk_shadowColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_shadowColorPicker));
}

- (void)setDk_shadowColorPicker:(NNColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dk_shadowColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.shadowColor = picker().CGColor;
    [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setShadowColor:))];
}

- (NNColorPicker)dk_borderColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_borderColorPicker));
}

- (void)setDk_borderColorPicker:(NNColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dk_borderColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.borderColor = picker().CGColor;
    [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setBorderColor:))];
}

- (NNColorPicker)dk_backgroundColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_backgroundColorPicker));
}

- (void)setDk_backgroundColorPicker:(NNColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dk_backgroundColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.backgroundColor = picker().CGColor;
    [self.pickers setValue:[picker copy] forKey:NSStringFromSelector(@selector(setBorderColor:))];
}

- (void)night_updateColor {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, NNColorPicker  _Nonnull picker, BOOL * _Nonnull stop) {
        CGColorRef result = picker().CGColor;
        [UIView animateWithDuration:NNNightNightAnimationDuration
                         animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             if ([selector isEqualToString:NSStringFromSelector(@selector(setShadowColor:))]) {
                                 [self setShadowColor:result];
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setBorderColor:))]) {
                                 [self setBorderColor:result];
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setBackgroundColor:)) ]) {
                                 [self setBackgroundColor:result];
                             }
#pragma clang diagnostic pop
                         }];
    }];
}

@end
