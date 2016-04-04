//
//  NNNightManager.h
//  NNNightManager
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNColor.h"
#import "NNImage.h"

/**
 *  DKThemeVersion is just a alias to string, use `- isEqualToString` to
 *  compare with each `DKThemeVersion` instead of symbol `==`.
 */
typedef NSString DKThemeVersion;

/**
 *  DKThemeVersionNormal is just a const string @"NORMAL", but use `- isEqualToString:`
 *  to compare with another string.
 */
extern DKThemeVersion * const DKThemeVersionNormal;

/**
 *  DKThemeVersionNight is just a const string @"NIGHT", but use `- isEqualToString:`
 *  to compare with another string.
 */
extern DKThemeVersion * const DKThemeVersionNight;

/**
 *  This notification will post, every time you change current theme version
 *  of NNNightManager glbal instance.
 */
extern NSString * const NNNightNightThemeChangingNotificaiton;

/**
 *  When change theme version, it will gives us a smooth animation. And this
 *  is the duration for this animation.
 */
extern CGFloat const NNNightNightAnimationDuration;

/**
 *  NNNightManager is the core class for NNNightNight, it manages all
 *  the different themes in the color table. Use `- sharedInstance` instead of 
 *  `- init` to get an instance.
 */
@interface NNNightManager : NSObject

/**
 *  if `changeStatusBar` is set to `YES`, the status bar will change to `UIStatusBarStyleLightContent` when invoke `+ nightFalling` and `UIStatusBarStyleDefault` for `+ dawnComing`. if you would like to use `-[UIViewController preferredStatusBarStyle]`, set this value to `NO`. Default to `YES`
 */
@property (nonatomic, assign, getter=shouldChangeStatusBar) BOOL changeStatusBar;

/**
 *  Current ThemeVersion, default is DKThemeVersionNormal, change it to change the global
 *  theme, this will post `NNNightNightThemeChangingNotificaiton`, if you want to customize
 *  your theme you can observe this notification.
 *  
 *  Ex:
 *
 *      ```objectivec
 *          NNNightManager *manager = [NNNightManager sharedManager];
 *          manager.themeVersion = @"RED"; // DKThemeVersionNormal or DKThemeVersionNight
 *      ```
 *
 */
@property (nonatomic, strong) DKThemeVersion *themeVersion;

/**
 *  Return the shared night version manager instance
 *
 *  @return singleton instance for NNNightManager
 */
+ (NNNightManager *)sharedManager;

/**
 *  Night falling. When nightFalling is called, post `NNNightNightThemeChangingNotificaiton`.
 *  You can setup customize with observing the notification. `themeVersion` of the manager will
 *  be set to `NNNightNightNight`. This is a convinient method for switching theme the
 *  `DKThemeVersionNight`.
 */
+ (void)nightFalling;

/**
 *  Dawn coming. When dawnComing is called, post `NNNightNightThemeChangingNotificaiton`.
 *  You can setup customize with observing the notification.`themeVersion` of the manager will
 *  be set to `NNNightNightNormal`. This is a convinient method for switching theme the
 *  `DKThemeVersionNormal`.
 */
+ (void)dawnComing;

/** 
 *  This method is deprecated, use `- [NNNightNight sharedManager]` instead
 */
+ (NNNightManager *)sharedNightVersionManager __deprecated_msg("use `- [NNNightNight sharedManager]` instead");

@end
