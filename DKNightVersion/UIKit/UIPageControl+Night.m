//
//  UIPageControl+Night.m
//  UIPageControl+Night
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UIPageControl+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UIPageControl ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers;

@end

@implementation UIPageControl (Night)


- (DKColorPicker)dk_pageIndicatorTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_pageIndicatorTintColorPicker));
}

- (void)dk_setPageIndicatorTintColorPicker:(DKColorPicker)picker {
    DKColorPickerChecker
    objc_setAssociatedObject(self, @selector(dk_pageIndicatorTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.pageIndicatorTintColor = picker(self.dk_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setPageIndicatorTintColor:"];
}

- (DKColorPicker)dk_currentPageIndicatorTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_currentPageIndicatorTintColorPicker));
}

- (void)dk_setCurrentPageIndicatorTintColorPicker:(DKColorPicker)picker {
    DKColorPickerChecker
    objc_setAssociatedObject(self, @selector(dk_currentPageIndicatorTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.currentPageIndicatorTintColor = picker(self.dk_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setCurrentPageIndicatorTintColor:"];
}


@end
