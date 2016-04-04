//
//  NNImage.h
//  NNNightNight
//
//  Created by Draveness on 15/12/10.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIImage *(^NNImagePicker)(void);

NNImagePicker NNImageWithNames(NSString *normal, NSString *night);
NNImagePicker NNImageWithImages(UIImage *normal, UIImage *night);

@interface NNImage : NSObject

+ (NNImagePicker)imageNamed:(NSString *)name;
+ (NNImagePicker)pickerWithNormalImage:(UIImage *)normalImage nightImage:(UIImage *)nightImage;

@end
