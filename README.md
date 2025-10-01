# LWDrawboard

[![CI Status](https://img.shields.io/travis/luowei/LWDrawboard.svg?style=flat)](https://travis-ci.org/luowei/LWDrawboard)
[![Version](https://img.shields.io/cocoapods/v/LWDrawboard.svg?style=flat)](https://cocoapods.org/pods/LWDrawboard)
[![License](https://img.shields.io/cocoapods/l/LWDrawboard.svg?style=flat)](https://cocoapods.org/pods/LWDrawboard)
[![Platform](https://img.shields.io/cocoapods/p/LWDrawboard.svg?style=flat)](https://cocoapods.org/pods/LWDrawboard)

[中文文档](README_ZH.md) | English

## Introduction

LWDrawboard is a powerful iOS drawing board and doodling library that supports customizable brush size and colors. It provides rich drawing tools and features, including:

- Free drawing with customizable brush size and color
- Draw geometric shapes: rectangles, circles, polygons, arrows
- Text input and editing with multiple font styles
- Mosaic effects
- Image cropping functionality
- Chinese brush calligraphy effect
- Handwriting input support
- Emoji and image stickers
- Eraser tool
- Shadow effects support

## Features

### Core Features

- **Multiple Drawing Tools**
  - Free brush (Hand)
  - Eraser (Erase)
  - Line (Line)
  - Arrow (LineArrow)
  - Rectangle (Rectangle, RectangleDash, RectangleFill)
  - Circle/Oval (Oval, OvalDash, OvalFill)
  - Dashed lines (LineDash, CurveDash)
  - Chinese brush (ChinesePen)

- **Text and Stickers**
  - Text input and editing (Text)
  - Multiple font support (including Helvetica, PingFang, STFangsong, etc.)
  - Emoji stickers (EmojiTile)
  - Image stickers (ImageTile)

- **Advanced Features**
  - Adjustable brush width (5-13pt)
  - Custom color picker (18 preset colors)
  - Background image and background color settings
  - Shadow effect toggle
  - Shape rotation and scaling
  - Undo/Redo functionality
  - Save as image

### Professional Features

- **AFBrushBoard** - Chinese brush calligraphy board, implementing realistic brush writing effects
- **LWHandwrittingView** - Handwriting input view, supporting handwriting recognition and path tracking
- **LWDrawView** - Main drawing view, supporting multiple drawing modes and editing functions

## Requirements

- iOS 8.0 or higher
- Xcode 9.0+
- Swift 4.0+ / Objective-C

## Installation

### CocoaPods

LWDrawboard is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'LWDrawboard'
```

Then run:

```bash
pod install
```

### Carthage

Add the following to your Cartfile:

```ruby
github "luowei/LWDrawboard"
```

Then run:

```bash
carthage update
```

## Usage

### Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

The example project contains two main usage examples:
- `LWBrushBoardViewController` - Demonstrates the use of the brush board
- `LWHandwrittingViewController` - Demonstrates handwriting input usage

### Basic Usage

#### 1. Create Chinese Brush Board (AFBrushBoard)

```objective-c
#import <LWDrawboard/AFBrushBoard.h>

// Create brush board
AFBrushBoard *brushBoard = [[AFBrushBoard alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];

// Set brush color
brushBoard.penColor = [UIColor blackColor];

// Set brush width (default is 13)
brushBoard.penWidth = 10;

// Add to view
[self.view addSubview:brushBoard];

// Clear the board
[brushBoard cleanDrawImage];
```

#### 2. Create Handwriting Input View (LWHandwrittingView)

```objective-c
#import <LWDrawboard/LWHandwrittingView.h>

// Create handwriting input view
LWHandwrittingView *handwritingView = [LWHandwrittingView handwrittingViewWithFrame:self.view.bounds
                                                                             delegate:self];

// Set line color
handwritingView.lineColor = [UIColor blueColor];

// Set line width
handwritingView.lineWidth = 2.0;

// Add to view
[self.view addSubview:handwritingView];
```

Implement delegate methods:

```objective-c
#pragma mark - LWHandwrittingViewProtocol

- (void)touchMovedWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints {
    // Callback when touch moves
    NSLog(@"Touch moved at: %@", NSStringFromCGPoint(touchPoint));
}

- (void)touchMoveEndWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints {
    // Callback when touch ends
    NSLog(@"Touch ended at: %@", NSStringFromCGPoint(touchPoint));
}

- (void)touchCancelledWithPathPoints:(NSMutableArray *)pathPoints {
    // Callback when touch is cancelled
    NSLog(@"Touch cancelled");
}
```

#### 3. Create Full Drawing View (LWDrawView)

```objective-c
#import <LWDrawboard/LWDrawView.h>
#import <LWDrawboard/LWDrawBar.h>

// Create drawing view
LWDrawView *drawView = [LWDrawView drawViewWithDelegate:self];
drawView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 60);

// Set background color
drawView.backgroundFillColor = [UIColor whiteColor];

// Set draw type
drawView.drawType = Hand; // Free brush

// Set brush color
drawView.freeInkColor = [UIColor blackColor];

// Set brush line width
drawView.freeInkLinewidth = 3.0;

// Enable shadow effect
drawView.openShadow = YES;

// Enable editing functionality
drawView.enableEdit = YES;

// Add to view
[self.view addSubview:drawView];

// Create toolbar
LWDrawBar *drawBar = [LWDrawBar drawBarWithFrame:CGRectMake(0, self.view.bounds.size.height - 60,
                                                              self.view.bounds.size.width, 60)];
[self.view addSubview:drawBar];
```

### Advanced Features

#### Switch Drawing Tools

```objective-c
// Switch to eraser mode
drawView.drawType = Erase;

// Switch to rectangle tool
drawView.drawType = Rectangle;

// Switch to oval tool
drawView.drawType = Oval;

// Switch to arrow tool
drawView.drawType = LineArrow;

// Switch to text tool
drawView.drawType = Text;

// Switch to Chinese brush tool
drawView.drawType = ChinesePen;
drawView.chinesePenWidth = 13.0;
```

#### Reset and Clear Board

```objective-c
// Reset the board (clear all content)
[drawView resetDrawing];

// Exit editing or text input mode
[drawView exitEditingOrTexting];
```

#### Set Font

```objective-c
// Set text font
drawView.fontName = @"PingFangSC-Regular";
```

#### Add Emoji or Image Stickers

```objective-c
// Add emoji sticker
drawView.drawType = EmojiTile;
drawView.tileEmojiText = @"😀";

// Add image sticker (requires implementing delegate method)
drawView.drawType = ImageTile;
drawView.tileAsset = photoAsset; // PHAsset object
```

Implement image request delegate method:

```objective-c
#pragma mark - LWDrawViewProtocol

- (void)requestTileImageForAsset:(PHAsset *)tileAsset
                            size:(CGSize)size
                      completion:(void (^)(UIImage *, NSDictionary *))completion {
    // Fetch image from photo library
    PHImageManager *manager = [PHImageManager defaultManager];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = NO;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;

    [manager requestImageForAsset:tileAsset
                       targetSize:size
                      contentMode:PHImageContentModeAspectFit
                          options:options
                    resultHandler:^(UIImage *result, NSDictionary *info) {
        if (completion) {
            completion(result, info);
        }
    }];
}
```

## API Documentation

### AFBrushBoard

Chinese brush calligraphy board.

#### Properties

- `penColor` (UIColor *) - Brush color
- `penWidth` (CGFloat) - Brush width, default value is 13

#### Methods

- `- (void)cleanDrawImage` - Clear the board content

---

### LWHandwrittingView

Handwriting input view, supporting handwriting recognition and path tracking.

#### Properties

- `delegate` (id<LWHandwrittingViewProtocol>) - Delegate object
- `pathes` (NSMutableArray *) - Array of drawing paths
- `lineWidth` (CGFloat) - Line width
- `lineColor` (UIColor *) - Line color

#### Methods

- `+ (instancetype)handwrittingViewWithFrame:(CGRect)frame delegate:(id<LWHandwrittingViewProtocol>)delegate` - Create handwriting input view

#### Delegate Methods (LWHandwrittingViewProtocol)

```objective-c
@optional
- (void)touchMovedWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints;
- (void)touchMoveEndWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints;
- (void)touchCancelledWithPathPoints:(NSMutableArray *)pathPoints;
```

---

### LWDrawView

Main drawing view, providing complete drawing and editing functionality.

#### Properties

##### Drawing Settings
- `drawType` (DrawType) - Current drawing tool type
- `freeInkColor` (UIColor *) - Free brush color
- `freeInkLinewidth` (CGFloat) - Free brush line width
- `chinesePenWidth` (CGFloat) - Chinese brush width

##### Background Settings
- `backgroundImage` (UIImage *) - Background image
- `backgroundFillColor` (UIColor *) - Background color

##### Feature Toggles
- `enableEdit` (BOOL) - Whether to enable editing functionality
- `openShadow` (BOOL) - Whether to enable shadow effects
- `drawStatus` (DrawStatus) - Current drawing status (Drawing/Editing/Texting)

##### Text and Stickers
- `fontName` (NSString *) - Text font name
- `tileEmojiText` (NSString *) - Emoji text
- `tileAsset` (PHAsset *) - Image asset

##### Internal Components
- `curves` (NSMutableArray *) - Collection of curves
- `textView` (LWScratchTextView *) - Text input view
- `controlView` (LWControlView *) - Control view

#### Methods

- `+ (instancetype)drawViewWithDelegate:(id<LWDrawViewProtocol>)delegate` - Create drawing view
- `- (void)resetDrawing` - Reset the board (clear all content)
- `- (void)exitEditingOrTexting` - Exit editing or text input mode

#### Delegate Methods (LWDrawViewProtocol)

```objective-c
@optional
- (void)requestTileImageForAsset:(PHAsset *)tileAsset
                            size:(CGSize)size
                      completion:(void (^)(UIImage *, NSDictionary *))completion;
```

---

### LWDrawBar

Drawing toolbar.

#### Methods

- `+ (LWDrawBar *)drawBarWithFrame:(CGRect)frame` - Create toolbar

---

### DrawType Enumeration

Drawing tool types:

```objective-c
typedef NS_OPTIONS(NSUInteger, DrawType) {
    Hand = 1,                // Free brush
    Erase = 1 << 1,         // Eraser
    Line = 1 << 2,          // Line
    LineArrow = 1 << 3,     // Arrow
    Rectangle = 1 << 4,     // Rectangle
    Oval = 1 << 5,          // Oval
    Text = 1 << 6,          // Text
    EmojiTile = 1 << 7,     // Emoji sticker
    ImageTile = 1 << 8,     // Image sticker
    RectangleDash = 1 << 9, // Dashed rectangle
    RectangleFill = 1 << 10,// Filled rectangle
    OvalDash = 1 << 11,     // Dashed oval
    OvalFill = 1 << 12,     // Filled oval
    LineDash = 1 << 13,     // Dashed line
    CurveDash = 1 << 14,    // Dashed curve
    ChinesePen = 1 << 15,   // Chinese brush
};
```

### DrawStatus Enumeration

Drawing status:

```objective-c
typedef NS_OPTIONS(NSUInteger, DrawStatus) {
    Drawing = 1,   // Drawing mode
    Editing = 2,   // Editing mode
    Texting = 3,   // Text input mode
};
```

## Dependencies

LWDrawboard depends on the following third-party libraries:

- [Masonry](https://github.com/SnapKit/Masonry) - Auto Layout library
- [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Image loading and caching library

These dependencies will be automatically included when installing via CocoaPods or Carthage.

## FAQ

### 1. How to save the board content as an image?

```objective-c
// Save view content as image
UIGraphicsBeginImageContextWithOptions(drawView.bounds.size, NO, 0.0);
[drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

// Save to photo library
UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
```

### 2. How to customize the color picker?

LWDrawBar already has a built-in color picker with 18 preset colors. To customize, you can modify the color values in the `DrawView_Color_Items` macro definition.

### 3. How to add custom fonts?

Add the font file to your project and register it in Info.plist. Then use the font name:

```objective-c
drawView.fontName = @"YourCustomFont-Regular";
```

### 4. How is the Chinese brush effect implemented?

The Chinese brush effect is implemented through the AFBrushBoard class, which uses Bezier curves and touch pressure to simulate realistic brush writing effects.

## Contributing

Issues and Pull Requests are welcome!

## Author

luowei, luowei@wodedata.com

## License

LWDrawboard is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
