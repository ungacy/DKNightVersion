//
//  SuccViewController.m
//  NNNightNight
//
//  Created by Draveness on 4/28/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import "SuccViewController.h"
#import "NNNightNight.h"

@interface SuccViewController ()

@end

@implementation SuccViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.dk_backgroundColorPicker = DKPickerWithKey(BG);
    self.navigationController.navigationBar.dk_tintColorPicker = NNColorWithColors([UIColor blueColor], [UIColor redColor]);
}

@end
