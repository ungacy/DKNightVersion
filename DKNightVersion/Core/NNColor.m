//
//  NNColor.m
//  NNNightNight
//
//  Created by Draveness on 15/12/9.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "NNColor.h"
#import "NNNightManager.h"

@implementation NNColor

NNColorPicker NNColorWithRGB(NSUInteger normal, NSUInteger night) {
    UIColor *normalColor = [UIColor colorWithRed:((float)((normal & 0xFF0000) >> 16))/255.0 green:((float)((normal & 0xFF00) >> 8))/255.0 blue:((float)(normal & 0xFF))/255.0 alpha:1.0];
    UIColor *nightColor = [UIColor colorWithRed:((float)((night & 0xFF0000) >> 16))/255.0 green:((float)((night & 0xFF00) >> 8))/255.0 blue:((float)(night & 0xFF))/255.0 alpha:1.0];
    return NNColorWithColors(normalColor, nightColor);
}

NNColorPicker NNColorWithColors(UIColor *normalColor, UIColor *nightColor) {
    return ^() {
        NNNightManager *manager = [NNNightManager sharedManager];
        return [manager.themeVersion isEqualToString:DKThemeVersionNormal] ? normalColor : nightColor;
    };
}

+ (NNColorPicker)pickerWithNormalColor:(UIColor *)normalColor nightColor:(UIColor *)nightColor {
    return ^() {
        NNNightManager *manager = [NNNightManager sharedManager];
        return [manager.themeVersion isEqualToString:DKThemeVersionNormal] ? normalColor : nightColor;
    };
}

+ (NNColorPicker)pickerWithUIColor:(UIColor *)color {
    return ^() {
        return color;
    };
}

+ (NNColorPicker)blackColor {
    return [self pickerWithUIColor:[UIColor blackColor]];
}

+ (NNColorPicker)darkGrayColor {
    return [self pickerWithUIColor:[UIColor darkGrayColor]];
}

+ (NNColorPicker)lightGrayColor {
    return [self pickerWithUIColor:[UIColor lightGrayColor]];
}

+ (NNColorPicker)whiteColor {
    return [self pickerWithUIColor:[UIColor whiteColor]];
}

+ (NNColorPicker)grayColor {
    return [self pickerWithUIColor:[UIColor grayColor]];
}

+ (NNColorPicker)redColor {
    return [self pickerWithUIColor:[UIColor redColor]];
}

+ (NNColorPicker)greenColor {
    return [self pickerWithUIColor:[UIColor greenColor]];
}

+ (NNColorPicker)blueColor {
    return [self pickerWithUIColor:[UIColor blueColor]];
}

+ (NNColorPicker)cyanColor {
    return [self pickerWithUIColor:[UIColor cyanColor]];
}

+ (NNColorPicker)yellowColor {
    return [self pickerWithUIColor:[UIColor yellowColor]];
}

+ (NNColorPicker)magentaColor {
    return [self pickerWithUIColor:[UIColor magentaColor]];
}

+ (NNColorPicker)orangeColor {
    return [self pickerWithUIColor:[UIColor orangeColor]];
}

+ (NNColorPicker)purpleColor {
    return [self pickerWithUIColor:[UIColor purpleColor]];
}

+ (NNColorPicker)brownColor {
    return [self pickerWithUIColor:[UIColor brownColor]];
}

+ (NNColorPicker)clearColor {
    return [self pickerWithUIColor:[UIColor clearColor]];
}

+ (NNColorPicker)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
    return [self pickerWithUIColor:[UIColor colorWithWhite:white alpha:alpha]];
}

+ (NNColorPicker)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
    return [self pickerWithUIColor:[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha]];
}

+ (NNColorPicker)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [self pickerWithUIColor:[UIColor colorWithRed:red green:green blue:blue alpha:alpha]];
}

+ (NNColorPicker)colorWithCGColor:(CGColorRef)cgColor {
    return [self pickerWithUIColor:[UIColor colorWithCGColor:cgColor]];
}

+ (NNColorPicker)colorWithPatternImage:(UIImage *)image {
    return [self pickerWithUIColor:[UIColor colorWithPatternImage:image]];
}

#if __has_include(<CoreImage/CoreImage.h>)
+ (NNColorPicker)colorWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0) {
    return [self pickerWithUIColor:[UIColor colorWithCIColor:ciColor]];
}
#endif

@end

