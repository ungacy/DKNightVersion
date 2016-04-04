//
//  NNNightManagerTest.m
//  NNNightNight
//
//  Created by Draveness on 15/5/5.
//  Copyright (c) 2015年 DeltaX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NNNightManager.h"

@interface NNNightManagerTest : XCTestCase

@property (nonatomic, strong) NNNightManager *manager;

@end

@implementation NNNightManagerTest

- (void)setUp {
    [super setUp];
    self.manager = [NNNightManager sharedManager];
}

- (void)tearDown {
    [super tearDown];
    self.manager = nil;
}

- (void)testDawnComing {
    [NNNightManager dawnComing];
    DKThemeVersion *themeVersion = self.manager.themeVersion;
    XCTAssert([self.manager.themeVersion isEqualToString:themeVersion], @"After execute dawn coming method, NNNightManager theme version should be DKThemeVersionNormal");
}

- (void)testNightFalling {
    [NNNightManager nightFalling];
    DKThemeVersion *themeVersion = self.manager.themeVersion;
    XCTAssert([self.manager.themeVersion isEqualToString:themeVersion], @"After execute night falling method, NNNightManager theme version should be DKThemeVersionNight");
}

- (void)testDawnComingPerformance {
    [self measureBlock:^{
        [NNNightManager dawnComing];
    }];
}

- (void)testNightFallingPerformance {
    [self measureBlock:^{
        [NNNightManager nightFalling];
    }];
}

@end
