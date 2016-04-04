//
//  CALayer+Night.h
//  NNNightNight
//
//  Created by Draveness on 16/1/29.
//  Copyright © 2016年 DeltaX. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NSObject+Night.h"

@interface CALayer (Night)

@property (nonatomic, copy) NNColorPicker dk_shadowColorPicker;
@property (nonatomic, copy) NNColorPicker dk_borderColorPicker;
@property (nonatomic, copy) NNColorPicker dk_backgroundColorPicker;

@end
