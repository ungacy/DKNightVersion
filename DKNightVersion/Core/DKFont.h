//
//  DKFont.h
//  DKNightVersion
//
//  Created by YeTao on 2016/11/17.
//  Copyright © 2016年 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSString DKThemeVersion;

typedef UIFont * (^DKFontPicker)(DKThemeVersion *themeVersion);

/**
 *  A C function takes an array of fonts return a font picker, the
 *  order of the fonts is just like the themes order in DKFontTable.txt
 *  file.
 *
 *  @param normalFont  Fonte when current themeVersion is DKThemeVersionNormal
 *  @param ...         Other Fonts, the order is the same as DKFontTable.txt
 *
 *  @return A DKFontPicker
 */
DKFontPicker DKFontPickerWithFonts(UIFont *normalFont, ...);

typedef UIFont * (^DKFontGenerator)(NSString *fontElement);

@interface DKFont : NSObject

/**
 *  A method takes an array of fonts return a font picker, the
 *  order of the fonts is just like the themes order in DKFontTable.txt
 *  file.
 *
 *  @param fonts An array of font names
 *
 *  @return A DKFontPicker
 */
+ (DKFontPicker)pickerWithFonts:(NSArray<UIFont *> *)fonts;

@end
