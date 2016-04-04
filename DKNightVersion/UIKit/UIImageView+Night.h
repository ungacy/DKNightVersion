//
//  UIImageView+Night.h
//  NNNightNight
//
//  Created by Draveness on 15/12/10.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNNightManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Night)

- (instancetype)dk_initWithImagePicker:(NNImagePicker)picker;

@property (nullable, nonatomic, copy, setter = dk_setImagePicker:) NNImagePicker dk_imagePicker;

@end

NS_ASSUME_NONNULL_END