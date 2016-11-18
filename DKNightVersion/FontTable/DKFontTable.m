//
//  DKFontTable.m
//  DKNightVersion
//
//  Created by YeTao on 2016/11/17.
//  Copyright © 2016年 Draveness. All rights reserved.
//

#import "DKFontTable.h"

@interface NSString (Trimming)
- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;
@end


@interface DKFontTable ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, UIFont *> *> *table;
@property (nonatomic, strong, readwrite) NSArray<DKThemeVersion *> *themes;
@property (nonatomic, copy) DKFontGenerator generator;

@end

@implementation DKFontTable

+ (instancetype)sharedFontTable {
    static DKFontTable *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[DKFontTable alloc] init];
    });
    return sharedInstance;
}

- (void)reloadFontTable {
    // Clear previos font table
    self.table = nil;
    self.themes = nil;
    
    // Load font table file
    NSString *filepath = [[NSBundle mainBundle] pathForResource:self.file.stringByDeletingPathExtension ofType:self.file.pathExtension];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
    
    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
    
    
    NSMutableArray *tempEntries = [[fileContents componentsSeparatedByString:@"\n"] mutableCopy];
    
    // Fixed whitespace error in txt file, fix https://github.com/Draveness/DKNightVersion/issues/64
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    [tempEntries enumerateObjectsUsingBlock:^(NSString *  _Nonnull entry, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *trimmingEntry = [entry stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [entries addObject:trimmingEntry];
    }];
    [entries filterUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    
    [entries removeObjectAtIndex:0]; // Remove theme entry
    
    self.themes = [self themesFromContents:fileContents];
    
    // Add entry to font table
    for (NSString *entry in entries) {
        NSArray *fonts = [self fontsFromEntry:entry];
        NSString *keys = [self keyFromEntry:entry];
        
        [self addEntryWithKey:keys fonts:fonts themes:self.themes];
    }
}

- (NSArray *)themesFromContents:(NSString *)content {
    NSString *rawThemes = [content componentsSeparatedByString:@"\n"].firstObject;
    return [self separateString:rawThemes];
}

- (NSArray *)fontsFromEntry:(NSString *)entry {
    NSMutableArray *fonts = [[self separateString:entry] mutableCopy];
    [fonts removeLastObject];
    NSMutableArray *result = [@[] mutableCopy];
    for (NSString *number in fonts) {
        [result addObject:[self fontFromString:number]];
    }
    return result;
}

- (NSString *)keyFromEntry:(NSString *)entry {
    return [self separateString:entry].lastObject;
}

- (void)addEntryWithKey:(NSString *)key fonts:(NSArray *)fonts themes:(NSArray *)themes {
    NSParameterAssert(themes.count == fonts.count);
    
    __block NSMutableDictionary *themeToFontDictionary = [@{} mutableCopy];
    
    [themes enumerateObjectsUsingBlock:^(NSString * _Nonnull theme, NSUInteger idx, BOOL * _Nonnull stop) {
        [themeToFontDictionary setValue:fonts[idx] forKey:theme];
    }];
    
    [self.table setValue:themeToFontDictionary forKey:key];
}

- (DKFontPicker)pickerWithKey:(NSString *)key {
    NSParameterAssert(key);
    
    NSDictionary *themeToFontDictionary = [self.table valueForKey:key];
    DKFontPicker picker = ^(DKThemeVersion *themeVersion) {
        return [themeToFontDictionary valueForKey:themeVersion];
    };
    return picker;
    
}

#pragma mark - Getter/Setter

- (NSMutableDictionary *)table {
    if (!_table) {
        _table = [[NSMutableDictionary alloc] init];
    }
    return _table;
}

- (void)setFile:(NSString *)file {
    _file = file;
    [self reloadFontTable];
}

#pragma mark - Helper

- (UIFont *)fontFromString:(NSString*)fontElement {
    NSAssert(self.generator, @"Please set your own DKFontGenerator");
    if (self.generator) {
        return self.generator(fontElement);
    }
    return nil;
}

- (NSArray *)separateString:(NSString *)string {
    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
}


@end
