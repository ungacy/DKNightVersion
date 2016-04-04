//
//  NNColor.h
//  NNNightNight
//
//  Created by Draveness on 15/12/9.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIColor *(^NNColorPicker)(void);

NNColorPicker NNColorWithRGB(NSUInteger normal, NSUInteger night);
NNColorPicker NNColorWithColors(UIColor *normalColor, UIColor *nightColor);

@interface NNColor : NSObject

+ (NNColorPicker)pickerWithUIColor:(UIColor *)color;

+ (NNColorPicker)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
+ (NNColorPicker)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
+ (NNColorPicker)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (NNColorPicker)colorWithCGColor:(CGColorRef)cgColor;
+ (NNColorPicker)colorWithPatternImage:(UIImage *)image;
#if __has_include(<CoreImage/CoreImage.h>)
+ (NNColorPicker)colorWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0);
#endif

+ (NNColorPicker)blackColor;
+ (NNColorPicker)darkGrayColor;
+ (NNColorPicker)lightGrayColor;
+ (NNColorPicker)whiteColor;
+ (NNColorPicker)grayColor;
+ (NNColorPicker)redColor;
+ (NNColorPicker)greenColor;
+ (NNColorPicker)blueColor;
+ (NNColorPicker)cyanColor;
+ (NNColorPicker)yellowColor;
+ (NNColorPicker)magentaColor;
+ (NNColorPicker)orangeColor;
+ (NNColorPicker)purpleColor;
+ (NNColorPicker)brownColor;
+ (NNColorPicker)clearColor;

@end
