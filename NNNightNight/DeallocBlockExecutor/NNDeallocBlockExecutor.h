//
//  DeallocBlockExecutor.h
//  NNNightNight
//
//  Created by nathanwhy on 16/2/24.
//  Copyright © 2016年 Draveness. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNDeallocBlockExecutor : NSObject

+ (instancetype)executorWithDeallocBlock:(void (^)())deallocBlock;

@property (nonatomic, copy) void (^deallocBlock)();

@end
