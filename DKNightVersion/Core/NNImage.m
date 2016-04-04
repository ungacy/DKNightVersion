//
//  NNImage.m
//  NNNightNight
//
//  Created by Draveness on 15/12/10.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "NNImage.h"
#import "NNNightManager.h"

@implementation NNImage

NNImagePicker NNImageWithNames(NSString *normal, NSString *night) {
    return [NNImage pickerWithNormalImage:[UIImage imageNamed:normal] nightImage:[UIImage imageNamed:night]];
}

NNImagePicker NNImageWithImages(UIImage *normal, UIImage *night) {
    return [NNImage pickerWithNormalImage:normal nightImage:night];
}

+ (NNImagePicker)pickerWithNormalImage:(UIImage *)normalImage nightImage:(UIImage *)nightImage {
    NSAssert(normalImage, @"- pickerWithNormalImage:nightImage: lack parameter normalImage");
    NSAssert(nightImage, @"- pickerWithNormalImage:nightImage: lack parameter nightImage");
    return ^() {
        NNNightManager *manager = [NNNightManager sharedManager];
        return [manager.themeVersion isEqualToString:DKThemeVersionNormal] ? normalImage : nightImage;
    };
}

+ (NNImagePicker)pickerWithImage:(UIImage *)image {
    return ^() {
        return image;
    };
}

+ (NNImagePicker)imageNamed:(NSString *)name {
    return [self pickerWithImage:[UIImage imageNamed:name]];
}

@end
