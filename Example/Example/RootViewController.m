//
//  RootViewController.m
//  DKNightVerision
//
//  Created by Draveness on 4/14/15.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

#import "RootViewController.h"
#import "SuccViewController.h"
#import "PresentingViewController.h"
#import <DKNightVersion/DKNightVersion.h>
#import "TableViewCell.h"

@pickerify(TableViewCell, cellTintColor)

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * DKFontTable.txt is like this:
     *
     *  Ex1:
     *
     *      NORMAL   NIGHT   RED
     *      #S:25    #R:20   #S:25    SOME_REGULAR_FONT
     *      #S:18    #S:18   #S:18    SOME_SEMIBOLD_FONT
     */
    NSDictionary *fontMapping = @{@"#R":@"PingFangSC-Regular",
                                  @"#S":@"PingFangSC-Semibold",
                                  @"#L":@"PingFangSC-Light",
                                  @"#M":@"PingFangSC-Medium",
                                  };
    [[DKFontTable sharedFontTable] setGenerator:^UIFont *(NSString *fontElement) {
        NSArray *fontElememtArray = [fontElement componentsSeparatedByString:@":"];
        NSAssert([fontElememtArray count] >= 2, @"Failed to parse font!");
        NSString *abbrFontName = [fontElememtArray firstObject];
        CGFloat fontSize = [fontElememtArray[1] floatValue];
        NSString *fontName = fontMapping[abbrFontName];
        UIFont *font = [UIFont fontWithName:fontName size:fontSize];
        return font;
    }];
    
    /*
     //DKFontTable.txt is like this:
     //
     // Ex2:
     //
     //     NORMAL                   NIGHT                   RED
     //     PingFangSC-Light@25    PingFangSC-Semibold@26   PingFangSC-Regular@25    SOME_DEMO_FONT
     //
     
     [[DKFontTable sharedFontTable] setGenerator:^UIFont *(NSString *fontElement) {
         NSArray *fontElememtArray = [fontElement componentsSeparatedByString:@"@"];
         NSAssert([fontElememtArray count] >= 2, @"Failed to parse font!");
         NSString *fontName = [fontElememtArray firstObject];
         CGFloat fontSize = [[fontElememtArray lastObject] floatValue];
         UIFont *font = [UIFont fontWithName:fontName size:fontSize];
         return font;
     }];
     */
    
    [DKFontTable sharedFontTable].file = @"DKFontTable.txt";
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    navigationLabel.text = @"DKNightVersion";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = navigationLabel;

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Present" style:UIBarButtonItemStylePlain target:self action:@selector(present)];
    self.navigationItem.leftBarButtonItem = item;

    UIBarButtonItem *normalItem = [[UIBarButtonItem alloc] initWithTitle:@"Normal" style:UIBarButtonItemStylePlain target:self action:@selector(normal)];
    normalItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    UIBarButtonItem *nightItem = [[UIBarButtonItem alloc] initWithTitle:@"Night" style:UIBarButtonItemStylePlain target:self action:@selector(night)];
    nightItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
    UIBarButtonItem *redItem = [[UIBarButtonItem alloc] initWithTitle:@"Red" style:UIBarButtonItemStylePlain target:self action:@selector(red)];
    redItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);

    self.navigationItem.rightBarButtonItems = @[normalItem, nightItem, redItem];
    DKColorDefaultPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);
    DKFontDefaultPicker = DKFontPickerWithFonts([UIFont italicSystemFontOfSize:14],[UIFont systemFontOfSize:15],[UIFont boldSystemFontOfSize:16]);
//    self.tableView.dk_backgroundColorPicker =  DKColorPickerWithKey(BG);
//    self.tableView.dk_backgroundColorPicker = nil;
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
//    navigationLabel.dk_fontPicker = nil;
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
    self.navigationItem.leftBarButtonItem.dk_tintColorPicker = DKColorPickerWithKey(TINT);
}

- (void)night {
    self.dk_manager.themeVersion = DKThemeVersionNight;
}

- (void)normal {
    self.dk_manager.themeVersion = DKThemeVersionNormal;
}

- (void)red {
    self.dk_manager.themeVersion = @"RED";
}

- (void)change {

    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNight]) {
        [self.dk_manager dawnComing];
    } else {
        [self.dk_manager nightFalling];
    }
}

- (void)push {
    [self.navigationController pushViewController:[[SuccViewController alloc] init] animated:YES];
}

- (void)present {
    [self presentViewController:[[PresentingViewController alloc] init] animated:YES completion:nil];
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.dk_cellTintColorPicker = DKColorPickerWithRGB(0xffffff, 0x343434, 0xfafafa);

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self push];
}

@end
