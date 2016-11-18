//
//  DKFont.m
//  DKNightVersion
//
//  Created by YeTao on 2016/11/17.
//  Copyright © 2016年 Draveness. All rights reserved.
//

#import "DKFont.h"
#import "DKFontTable.h"

@implementation DKFont

DKFontPicker DKFontPickerWithFonts(UIFont *normalFont, ...) {
    NSArray<DKThemeVersion *> *themes = [DKFontTable sharedFontTable].themes;
    NSMutableArray<UIFont *> *fonts = [[NSMutableArray alloc] initWithCapacity:themes.count];
    [fonts addObject:normalFont];
    NSUInteger num_args = themes.count - 1;
    va_list images_list;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wvarargs"
    va_start(images_list, num_args);
#pragma clang diagnostic pop
    for (NSUInteger i = 0; i < num_args; i++) {
        UIFont *font = va_arg(images_list, UIFont *);
        [fonts addObject:font];
    }
    va_end(images_list);
    
    return [DKFont pickerWithFonts:fonts];
}

+ (DKFontPicker)pickerWithFonts:(NSArray<UIFont *> *)fonts {
    DKFontTable *fontTable = [DKFontTable sharedFontTable];
    NSParameterAssert(fonts.count == fontTable.themes.count);
    return ^(DKThemeVersion *themeVersion) {
        NSUInteger index = [fontTable.themes indexOfObject:themeVersion];
        if (index >= fontTable.themes.count) {
            return fonts[[fontTable.themes indexOfObject:DKThemeVersionNormal]];
        }
        return fonts[index];
    };
}

@end
