//
//  UIButton+Night.h
//  NNNightNight
//
//  Created by Draveness on 15/12/9.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Night.h"

@interface UIButton (Night)

- (void)dk_setTitleColorPicker:(NNColorPicker)picker forState:(UIControlState)state;

- (void)dk_setBackgroundImage:(NNImagePicker)picker forState:(UIControlState)state;

- (void)dk_setImage:(NNImagePicker)picker forState:(UIControlState)state;

@end
