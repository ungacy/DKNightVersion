//
//  UIImageView+Night.m
//  NNNightNight
//
//  Created by Draveness on 15/12/10.
//  Copyright © 2015年 DeltaX. All rights reserved.
//

#import "UIImageView+Night.h"
#import "NSObject+Night.h"
#import <objc/runtime.h>

@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NNColorPicker> *pickers;

@end

@implementation UIImageView (Night)

- (instancetype)dk_initWithImagePicker:(NNImagePicker)picker {
    UIImageView *imageView = [self initWithImage:picker()];
    imageView.dk_imagePicker = [picker copy];
    return imageView;
}

- (NNImagePicker)dk_imagePicker {
    return objc_getAssociatedObject(self, @selector(dk_imagePicker));
}

- (void)dk_setImagePicker:(NNImagePicker)picker {
    objc_setAssociatedObject(self, @selector(dk_imagePicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.image = picker();
    [self.pickers setValue:[picker copy] forKey:@"setImage:"];

}

@end
