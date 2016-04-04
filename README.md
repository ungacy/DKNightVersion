![](./images/Banner.png)

<p align="center">
<a href="https://img.shields.io/badge/Language-%20Objective--C%20-orange.svg"><img src="https://img.shields.io/badge/Language-%20Objective--C%20-orange.svg"></a>
<a href="http://cocoadocs.org/docsets/NNNightNight"><img src="http://img.shields.io/cocoapods/v/NNNightNight.svg?style=flat"></a>
<a href="https://travis-ci.org/Draveness/NNNightNight"><img src="https://travis-ci.org/Draveness/NNNightNight.png"></a>
<img src="https://img.shields.io/badge/license-MIT-blue.svg">
<a href="https://img.shields.io/badge/platform-%20iOS%20-lightgrey.svg"><img src="https://img.shields.io/badge/platform-%20iOS%20-lightgrey.svg"></a>
</p>

- [x] `UIColor` support
- [x] `UIImage` and `UIImageView` support
- [x] Hight performance
- [x] Providing UIKit categoty
- [x] Providing CoreAnimation categoty
- [x] Easily integrate to iOS App
- [x] Based on `objc/runtime`
- [x] Generate by ruby script
- [x] Read color customization from file
- [x] Support different themes
- [ ] Support NSAttributedString
- [ ] Default NNColorPicker

# Demo

![](./images/NNNightNight.gif)

# Installation with CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like NNNightNight in your projects. See the [Get Started section](https://cocoapods.org/#get_started) for more details.

## Podfile

Run following script in termianl

```shell
$ pod update
```

Add this line to your `podfile`

```shell
pod "NNNightNight", "~> 2.0.0"
```

## Usage

Just add one line of code in your precompiled header, or import it where you need.

```objectivec
#import "NNNightNight.h"
```

----

# How to use

## NNColorTable

+ Version 2.0 bring us a very powerful feature, NNNightNight **supported different themes and read color from a txt file**.

There is a `NNColorTable.txt` file in your project, you can also create it by yourself. NNNightNight will read color setting from this file when app is start launching. This file look like this.

```
NORMAL   NIGHT
#ffffff  #343434 BG
#aaaaaa  #313131 SEP
```

`NORMAL` is the default column, and `NIGHT` is for night mode, you can also create other theme `RED` like this:

```
NORMAL   NIGHT   RED
#ffffff  #343434 #ff0000 BG
#aaaaaa  #313131 #ff0000 SEP
```

When you successfully and `RED`, you can change to `RED` theme by this, it will trigger global theme change to `RED`.

```objectivec
[NNNightManager sharedManager].themeVersion = @"RED";
```

Use `DKPickerWithKey` to generate a NNColorPicker

```objectivec
self.view.dk_backgroundColorPicker = DKPickerWithKey(BG);
```

## Night color

NNNightNight is based on picker, such as `dk_backgroundColorPicker` `dk_separatorColorPicker` and etc. Assign the night mode color picker you want to the `UIKit` component like this:

```objectivec
self.tableView.dk_backgroundColorPicker =  NNColorWithRGB(0xffffff, 0x343434);
self.tableView.dk_separatorColorPicker = NNColorWithRGB(0xaaaaaa, 0x313131);
navigationLabel.dk_textColorPicker = NNColorWithColors([UIColor blackColor], [UIColor whiteColor]);
```

## Night Image

NNNightNight providing new `API` to support image switching.

```objectivec
imageView.dk_imagePicker = NNImageWithNames(@"normal1", @"night1");
```


## NNColor

`NNColor` provides `- pickerWithNormalColor:nightColor:` to create `NNColorPicker`.

```objectivec
NNColorPicker NNColorWithRGB(NSUInteger normal, NSUInteger night);
NNColorPicker NNColorWithColors(UIColor *normalColor, UIColor *nightColor);
```

`NNColor` also provides a cluster of convienient `API` like `UIColor` which returns `NNColorPicker` block, these block return the same color when switch to night mode or switch back.

```objectivec
+ (NNColorPicker)pickerWithUIColor:(UIColor *)color;
+ (NNColorPicker)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
+ (NNColorPicker)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
+ (NNColorPicker)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (NNColorPicker)colorWithCGColor:(CGColorRef)cgColor;
+ (NNColorPicker)colorWithPatternImage:(UIImage *)image;
#if __has_include(<CoreImage/CoreImage.h>)
+ (NNColorPicker)colorWithCIColor:(CIColor *)ciColor NS_AVAILABLE_IOS(5_0);
#endif

+ (NNColorPicker)blackColor;
+ (NNColorPicker)darkGrayColor;
+ (NNColorPicker)lightGrayColor;
+ (NNColorPicker)whiteColor;
+ (NNColorPicker)grayColor;
+ (NNColorPicker)redColor;
+ (NNColorPicker)greenColor;
+ (NNColorPicker)blueColor;
+ (NNColorPicker)cyanColor;
+ (NNColorPicker)yellowColor;
+ (NNColorPicker)magentaColor;
+ (NNColorPicker)orangeColor;
+ (NNColorPicker)purpleColor;
+ (NNColorPicker)brownColor;
+ (NNColorPicker)clearColor;
```

## NNColorTable

If you have the same `NNColorPicker` for different UIKit components, use `NNColorTable` to save them and take out of them with `DKPickerFromTable(NSString *key)` function.

NNColorTable provides three methods and a C function to manipulate color table and get picker from it.

```objectivec
DKPickerFromTable(NSString *key)

+ (void)addPicker:(NNColorPicker)picker withKey:(NSString *)key;
+ (NNColorPicker)removePickerWithKey:(NSString *)key;
+ (NNColorPicker)pickerWithKey:(NSString *)key;
```


## NNImage

NNImage is similar with NNColor which contains methods to generate `NNImagePicker`

```objectivec
NNImagePicker NNImageWithNames(NSString *normal, NSString *night);
NNImagePicker NNImageWithImages(UIImage *normal, UIImage *night);
```


## Using NNNightManager change theme

Use `NNNightManager` sets the theme.

```objectivec
[NNNightManager nightFalling];
```

If you'd like to switch back to normal mode:

```objectivec
[NNNightManager dawnComing];
```

It's pretty easy to swich theme between night and normal mode.

## Make your own customize

### Notification

`nightFalling` method will post `NNNightNightNightFallingNotification` when it is called. Similarly, `dawnComing` will post `NNNightNightDawnComingNotification`. You can observe these notification in proper place, and make your own customize easily.

# Contribute

Feel free to open an issue or pull request, if you need help or there is a bug.

# Contact

- Powered by [Draveness](http://github.com/draveness)
- Personal website [Draveness](http://draveness.me)

# Todo

- Documentation

# License

NNNightNight is available under the MIT license. See the LICENSE file for more info.

The MIT License (MIT)

Copyright (c) 2015 Draveness

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


