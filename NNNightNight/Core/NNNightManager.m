//
//  NNNightManager.m
//  NNNightManager
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import "NNNightManager.h"

NSString * const DKThemeVersionNormal = @"NORMAL";
NSString * const DKThemeVersionNight = @"NIGHT";

NSString * const NNNightNightThemeChangingNotificaiton = @"NNNightNightThemeChangingNotificaiton";

CGFloat const NNNightNightAnimationDuration = 0.3;

NSString * const NNNightNightCurrentThemeVersionKey = @"com.NNNightNight.manager.themeversion";

@interface NNNightManager ()

@end

@implementation NNNightManager

+ (NNNightManager *)sharedManager {
    static dispatch_once_t once;
    static NNNightManager *instance;
    dispatch_once(&once, ^{
        instance = [self new];
        instance.changeStatusBar = YES;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        DKThemeVersion *themeVersion = [userDefaults valueForKey:NNNightNightCurrentThemeVersionKey];
        themeVersion = themeVersion ?: DKThemeVersionNormal;
        instance.themeVersion = themeVersion;
    });
    return instance;
}

+ (NNNightManager *)sharedNightVersionManager {
    return [self sharedManager];
}

+ (void)nightFalling {
    NNNightManager *manager = [NNNightManager sharedManager];
    manager.themeVersion = DKThemeVersionNight;
}

+ (void)dawnComing {
    NNNightManager *manager = [NNNightManager sharedManager];
    manager.themeVersion = DKThemeVersionNormal;
}

- (void)setThemeVersion:(DKThemeVersion *)themeVersion {
    if ([_themeVersion isEqualToString:themeVersion]) {
        // if type does not change, don't execute code below to enhance performance.
        return;
    }
    _themeVersion = themeVersion;

    // Save current theme version to user default
    [[NSUserDefaults standardUserDefaults] setValue:themeVersion forKey:NNNightNightCurrentThemeVersionKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:NNNightNightThemeChangingNotificaiton
                                                        object:nil];

    if (self.shouldChangeStatusBar) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        if ([themeVersion isEqualToString:DKThemeVersionNormal]) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        } else {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
#pragma clang diagnostic pop
    }
}

@end
