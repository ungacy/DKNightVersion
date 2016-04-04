//
//  NNColorTable.h
//  NNNightNight
//
//  Created by Draveness on 15/12/11.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NNNightManager.h"

/**
 *  A convinient macro to create NNColorPicker block.
 *
 *  @param key Key for corresponding entry in table
 *
 *  @return NNColorPicker
 */
#define DKPickerWithKey(key) [[NNColorTable sharedColorTable] pickerWithKey:@#key]

/**
 *  NNColorTable is a new feature in 2.x, which providing you a very convinient and
 *  delightful approach to manage all your color in an iOS project. Besides that, we
 *  support multiple themes with NNColorTable, change your `NNColorTable.txt` file 
 *  like this:
 *  
 *  Ex:
 *
 *      NORMAL   NIGHT   RED
 *      #ffffff  #343434 #ff0000 BG
 *      #aaaaaa  #313131 #ff0000 SEP
 *
 *  And you can directly change `[NNNightManager sharedManager].themeVersion` to
 *  what you want, like: `RED` `NORMAL` and `NIGHT`. And trigger to post notification 
 *  and update corresponding color.
 */
@interface NNColorTable : NSObject

/**
 *  Call `- reloadColorTable` will trigger `NNColorTable` to load this file,
 *  default is `NNColorTable.txt`. Don't need to call `- reloadColorTable` after
 *  setting this property, cuz we have already do it for you.
 */
@property (nonatomic, strong) NSString *file;

/**
 *  Return color table instance, you MUST use this method instead of `- init`,
 *  `- init` method may have negative impact on your performance.
 *
 *  @return An instance of NNColorTable
 */
+ (instancetype)sharedColorTable;

/**
 *  Reload `file` into memory, and reconstrcut the whole color table. This method
 *  will clear color table and use current `file` to load color table again.
 */
- (void)reloadColorTable;

/**
 *  Return a `NNColorPicker` with `key`, but I suggest you use marcho `DKPickerWithKey(key)`
 *  instead of calling this method.
 *
 *  Ex:
 *
 *      NORMAL   NIGHT
 *      #ffffff  #343434 BG
 *      #aaaaaa  #313131 SEP
 *  
 *      self.view.dk_backgroundColorPicker = DKPickerWithKey(BG);
 *
 *  If current themeVersion is NORMAL, view's background color will be set to #ffffff. When theme
 *  changes, it will automatically reload color from global color table and update current color
 *  again.
 *
 *  @param key Which indicates the entry you refer to
 *
 *  @return An NNColorPicker block
 */
- (NNColorPicker)pickerWithKey:(NSString *)key;

@end
