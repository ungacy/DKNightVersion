//
//  DKFontTable.h
//  DKNightVersion
//
//  Created by YeTao on 2016/11/17.
//  Copyright © 2016年 Draveness. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKNightVersionManager.h"

/**
 *  A convinient macro to create DKFontPicker block.
 *
 *  @param key Key for corresponding entry in table
 *
 *  @return DKFontPicker
 */
#define DKFontWithPicker(picker)  picker(self.dk_manager.themeVersion)

#define DKFontPickerWithKey(key) [[DKFontTable sharedFontTable] pickerWithKey:@#key]

/**
 *  DKFontTable is a new feature in 2.x, which providing you a very convinient and
 *  delightful approach to manage all your font in an iOS project. Besides that, we
 *  support multiple themes with DKFontTable.
 *  But first of all,you should define your own block to generator UIFont according to
 *  each item you define in `DKFontTable.txt`. Just like code below
 *  @code
 *  NSDictionary *fontMapping = @{  @"#R":@"PingFangSC-Regular",
 *                                  @"#S":@"PingFangSC-Semibold",
 *                                  @"#L":@"PingFangSC-Light",
 *                                  @"#M":@"PingFangSC-Medium",
 *                             };
 *  [[DKFontTable sharedFontTable] setGenerator:^UIFont *(NSString *fontElement) {
 *      NSArray *fontElememtArray = [fontElement componentsSeparatedByString:@":"];
 *      NSAssert([fontElememtArray count] >= 2, @"Failed to parse font!");
 *      NSString *abbrFontName = [fontElememtArray firstObject];
 *      CGFloat fontSize = [fontElememtArray[1] floatValue];
 *      NSString *fontName = fontMapping[abbrFontName];
 *      UIFont *font = [UIFont fontWithName:fontName size:fontSize];
 *      return font;
 *  }];
 *  [DKFontTable sharedFontTable].file = @"DKFontTable.txt";
 *  @endcode
 *  change your `DKFontTable.txt` file
 *  like this:
 *
 *  Ex:
 *
 *      NORMAL   NIGHT   RED
 *      #S:25    #R:20   #S:25    SOME_REGULAR_FONT
 *      #S:18    #S:18   #S:18    SOME_SEMIBOLD_FONT
 *
 *  And you can directly change `[DKNightVersionManager sharedManager].themeVersion` to
 *  what you want, like: `RED` `NORMAL` and `NIGHT`. And trigger to post notification
 *  and update corresponding font.
 */
@interface DKFontTable : NSObject

/**
 *  Call `- sharedFontTable` will trigger `DKFontTable` to load this file,
 *  default is `DKFontTable.txt`. Don't need to call `- sharedFontTable` after
 *  setting this property, cuz we have already do it for you.
 */
@property (nonatomic, strong) NSString *file;

/**
 *  An array of DKThemeVersion, order is exactly the same in `file`.
 */
@property (nonatomic, strong, readonly) NSArray<DKThemeVersion *> *themes;

/**
 *  Return font table instance, you MUST use this method instead of `- init`,
 *  `- init` method may have negative impact on your performance.
 *
 *  @return An instance of DKFontTable
 */
+ (instancetype)sharedFontTable;

/**
 *  Reload `file` into memory, and reconstrcut the whole font table. This method
 *  will clear font table and use current `file` to load font table again.
 */
- (void)reloadFontTable;

/**
 *  Return a `DKFontPicker` with `key`, but I suggest you use marcho `DKFontWithPicker(key)`
 *  instead of calling this method.
 *
 *  Ex:
 *
 *      NORMAL   NIGHT   RED
 *      #S:25    #R:20   #S:25    SOME_REGULAR_FONT
 *
 *      self.label.dk_fontPicker = DKFontPickerWithKey(SOME_REGULAR_FONT);
 *
 *  If current themeVersion is NORMAL, label's font will be set to PingFangSC-Regular@25. When theme
 *  changes, it will automatically reload font from global font table and update current font
 *  again.
 *
 *  @param key Which indicates the entry you refer to
 *
 *  @return An DKFontPicker block
 */
- (DKFontPicker)pickerWithKey:(NSString *)key;

/*!
 *  @param generator Block to generator `UIFont` according to each item you define in `DKFontTable.txt`.
 */
- (void)setGenerator:(DKFontGenerator)generator;

@end
