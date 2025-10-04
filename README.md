# LWDrawboard

[![CI Status](https://img.shields.io/travis/luowei/LWDrawboard.svg?style=flat)](https://travis-ci.org/luowei/LWDrawboard)
[![Version](https://img.shields.io/cocoapods/v/LWDrawboard.svg?style=flat)](https://cocoapods.org/pods/LWDrawboard)
[![License](https://img.shields.io/cocoapods/l/LWDrawboard.svg?style=flat)](https://cocoapods.org/pods/LWDrawboard)
[![Platform](https://img.shields.io/cocoapods/p/LWDrawboard.svg?style=flat)](https://cocoapods.org/pods/LWDrawboard)

[English](./README.md) | [中文版](./README_ZH.md) | [Swift Version](./README_SWIFT_VERSION.md)

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Dependencies](#dependencies)
- [FAQ](#faq)
- [Contributing](#contributing)
- [License](#license)

## Introduction

LWDrawboard is a powerful and feature-rich iOS drawing board library designed for developers who need to implement drawing, doodling, and annotation functionality in their applications. Built with Objective-C, it provides a comprehensive set of tools and customization options for creating professional drawing experiences.

### Key Highlights

- **Multiple Drawing Tools**: Support for free drawing, geometric shapes, arrows, and more
- **Chinese Brush Calligraphy**: Realistic brush writing effects with pressure simulation
- **Text Annotation**: Full text input and editing capabilities with custom fonts
- **Stickers Support**: Add emoji and image stickers to your canvas
- **Advanced Features**: Shadow effects, undo/redo, image export, and customizable UI
- **Easy Integration**: Simple API design with delegate patterns
- **Production Ready**: Battle-tested in real-world applications

## Features

### Drawing Tools

LWDrawboard provides a comprehensive suite of drawing tools to meet various needs:

- **Free Brush (Hand)**: Natural freehand drawing with smooth curves
- **Eraser**: Remove unwanted strokes with precision
- **Geometric Shapes**:
  - Lines (solid and dashed)
  - Rectangles (outline, dashed, and filled)
  - Circles/Ovals (outline, dashed, and filled)
  - Arrows with customizable heads
- **Chinese Brush (ChinesePen)**: Realistic calligraphy effects with pressure simulation
- **Text Tool**: Add and edit text annotations with multiple font support

### Stickers and Media

- **Emoji Stickers**: Add emoji to your drawings
- **Image Stickers**: Insert photos and images from the photo library
- **Custom Positioning**: Drag, rotate, and scale stickers

### Customization Options

- **Brush Settings**:
  - Adjustable brush width (5-13pt)
  - Custom colors with 18 preset options
  - Shadow effects support
- **Background**:
  - Set background images
  - Customize background colors
- **Font Support**: Multiple font styles including Helvetica, PingFang, STFangsong, and custom fonts

### Professional Components

- **AFBrushBoard**: Specialized Chinese brush calligraphy board with realistic brush writing effects
- **LWHandwrittingView**: Handwriting input view with path tracking and recognition support
- **LWDrawView**: Main drawing canvas with complete drawing and editing capabilities
- **LWDrawBar**: Customizable toolbar with color picker and tool selector

### Advanced Functionality

- Undo/Redo operations
- Shape rotation and scaling
- Export drawings as UIImage
- Edit mode for modifying existing elements
- Multi-layer support
- Touch gesture recognition

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

### Quick Start

The fastest way to get started with LWDrawboard is to explore the example project:

```bash
git clone https://github.com/luowei/LWDrawboard.git
cd LWDrawboard/Example
pod install
open LWDrawboard.xcworkspace
```

The example project includes comprehensive demonstrations:
- **LWBrushBoardViewController**: Chinese brush calligraphy board usage
- **LWHandwrittingViewController**: Handwriting input and path tracking

### Basic Usage

#### 1. Chinese Brush Calligraphy Board

The `AFBrushBoard` component provides realistic Chinese brush calligraphy effects:

```objective-c
#import <LWDrawboard/AFBrushBoard.h>

// Initialize brush board
AFBrushBoard *brushBoard = [[AFBrushBoard alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];

// Configure brush properties
brushBoard.penColor = [UIColor blackColor];
brushBoard.penWidth = 10.0; // Default is 13

// Add to view hierarchy
[self.view addSubview:brushBoard];

// Clear all strokes
[brushBoard cleanDrawImage];
```

**Use Cases**: Calligraphy practice apps, signature collection, artistic drawing

#### 2. Handwriting Input View

The `LWHandwrittingView` component enables handwriting capture with path tracking:

```objective-c
#import <LWDrawboard/LWHandwrittingView.h>

// Create handwriting input view
LWHandwrittingView *handwritingView = [LWHandwrittingView handwrittingViewWithFrame:self.view.bounds
                                                                             delegate:self];

// Configure appearance
handwritingView.lineColor = [UIColor blueColor];
handwritingView.lineWidth = 2.0;

// Add to view hierarchy
[self.view addSubview:handwritingView];
```

**Implement the delegate protocol** to receive touch events:

```objective-c
#pragma mark - LWHandwrittingViewProtocol

- (void)touchMovedWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints {
    // Track drawing progress
    NSLog(@"Touch moved at: %@", NSStringFromCGPoint(touchPoint));
}

- (void)touchMoveEndWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints {
    // Handle stroke completion
    NSLog(@"Touch ended at: %@", NSStringFromCGPoint(touchPoint));
    // Process pathPoints for handwriting recognition
}

- (void)touchCancelledWithPathPoints:(NSMutableArray *)pathPoints {
    // Handle cancelled input
    NSLog(@"Touch cancelled");
}
```

**Use Cases**: Handwriting recognition, signature capture, gesture detection

#### 3. Full-Featured Drawing Canvas

The `LWDrawView` is the main component providing complete drawing functionality:

```objective-c
#import <LWDrawboard/LWDrawView.h>
#import <LWDrawboard/LWDrawBar.h>

// Initialize drawing view with delegate
LWDrawView *drawView = [LWDrawView drawViewWithDelegate:self];
drawView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 60);

// Configure background
drawView.backgroundFillColor = [UIColor whiteColor];

// Set initial drawing tool
drawView.drawType = Hand; // Free brush mode

// Configure brush properties
drawView.freeInkColor = [UIColor blackColor];
drawView.freeInkLinewidth = 3.0;

// Enable advanced features
drawView.openShadow = YES;    // Enable shadow effects
drawView.enableEdit = YES;    // Allow editing existing elements

// Add to view hierarchy
[self.view addSubview:drawView];

// Create and configure toolbar
CGFloat toolbarHeight = 60;
LWDrawBar *drawBar = [LWDrawBar drawBarWithFrame:CGRectMake(0,
                                                              self.view.bounds.size.height - toolbarHeight,
                                                              self.view.bounds.size.width,
                                                              toolbarHeight)];
[self.view addSubview:drawBar];
```

**Use Cases**: Image annotation, photo editing, whiteboard apps, note-taking

### Advanced Features

#### Switching Drawing Tools

LWDrawboard supports dynamic tool switching at runtime:

```objective-c
// Eraser mode
drawView.drawType = Erase;

// Geometric shapes
drawView.drawType = Rectangle;      // Outline rectangle
drawView.drawType = RectangleFill;  // Filled rectangle
drawView.drawType = RectangleDash;  // Dashed rectangle
drawView.drawType = Oval;           // Outline circle/oval
drawView.drawType = OvalFill;       // Filled circle/oval
drawView.drawType = OvalDash;       // Dashed circle/oval

// Lines and arrows
drawView.drawType = Line;           // Straight line
drawView.drawType = LineDash;       // Dashed line
drawView.drawType = LineArrow;      // Arrow

// Text annotation
drawView.drawType = Text;

// Chinese brush calligraphy
drawView.drawType = ChinesePen;
drawView.chinesePenWidth = 13.0;
```

#### Managing Drawing State

```objective-c
// Clear all content and reset the canvas
[drawView resetDrawing];

// Exit editing or text input mode
[drawView exitEditingOrTexting];

// Check current drawing status
if (drawView.drawStatus == Drawing) {
    // Currently drawing
} else if (drawView.drawStatus == Editing) {
    // Currently editing an element
} else if (drawView.drawStatus == Texting) {
    // Currently inputting text
}
```

#### Text and Fonts

```objective-c
// Set custom font for text annotations
drawView.fontName = @"PingFangSC-Regular";

// Available system fonts include:
// - Helvetica, Helvetica-Bold
// - PingFangSC-Regular, PingFangSC-Semibold
// - STFangsong, STHeiti
```

#### Working with Stickers

**Adding Emoji Stickers:**

```objective-c
// Set emoji sticker mode
drawView.drawType = EmojiTile;
drawView.tileEmojiText = @"😀";  // Any emoji character
```

**Adding Image Stickers:**

```objective-c
// Set image sticker mode
drawView.drawType = ImageTile;
drawView.tileAsset = photoAsset; // PHAsset object from photo library
```

**Implement the delegate method** to handle image loading:

```objective-c
#pragma mark - LWDrawViewProtocol

- (void)requestTileImageForAsset:(PHAsset *)tileAsset
                            size:(CGSize)size
                      completion:(void (^)(UIImage *, NSDictionary *))completion {
    // Request image from Photos framework
    PHImageManager *manager = [PHImageManager defaultManager];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = NO;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;

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

#### Exporting Drawings

```objective-c
// Export the entire canvas as UIImage
UIGraphicsBeginImageContextWithOptions(drawView.bounds.size, NO, [UIScreen mainScreen].scale);
[drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
UIImage *exportedImage = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

// Save to photo library
UIImageWriteToSavedPhotosAlbum(exportedImage, nil, nil, nil);
```

## API Documentation

### AFBrushBoard

`AFBrushBoard` is a specialized view for Chinese brush calligraphy with realistic stroke effects.

#### Properties

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `penColor` | `UIColor *` | Color of the brush stroke | Black |
| `penWidth` | `CGFloat` | Width of the brush stroke | 13.0 |

#### Methods

```objective-c
- (void)cleanDrawImage
```
Clears all content from the brush board.

---

### LWHandwrittingView

`LWHandwrittingView` captures handwriting input with path tracking for recognition purposes.

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `delegate` | `id<LWHandwrittingViewProtocol>` | Delegate for receiving touch events |
| `pathes` | `NSMutableArray *` | Array of captured drawing paths |
| `lineWidth` | `CGFloat` | Width of handwriting strokes |
| `lineColor` | `UIColor *` | Color of handwriting strokes |

#### Methods

```objective-c
+ (instancetype)handwrittingViewWithFrame:(CGRect)frame
                                 delegate:(id<LWHandwrittingViewProtocol>)delegate
```
Creates and initializes a handwriting input view.

#### LWHandwrittingViewProtocol

```objective-c
@protocol LWHandwrittingViewProtocol <NSObject>
@optional
- (void)touchMovedWithPoint:(CGPoint)touchPoint
                 pathPoints:(NSMutableArray *)pathPoints;
- (void)touchMoveEndWithPoint:(CGPoint)touchPoint
                   pathPoints:(NSMutableArray *)pathPoints;
- (void)touchCancelledWithPathPoints:(NSMutableArray *)pathPoints;
@end
```

---

### LWDrawView

`LWDrawView` is the primary drawing canvas with comprehensive drawing and editing capabilities.

#### Properties

**Drawing Configuration:**

| Property | Type | Description |
|----------|------|-------------|
| `drawType` | `DrawType` | Current drawing tool type |
| `freeInkColor` | `UIColor *` | Color for free brush strokes |
| `freeInkLinewidth` | `CGFloat` | Line width for free brush |
| `chinesePenWidth` | `CGFloat` | Width for Chinese brush tool |

**Background Configuration:**

| Property | Type | Description |
|----------|------|-------------|
| `backgroundImage` | `UIImage *` | Background image for the canvas |
| `backgroundFillColor` | `UIColor *` | Background color for the canvas |

**Feature Settings:**

| Property | Type | Description |
|----------|------|-------------|
| `enableEdit` | `BOOL` | Enable/disable editing of drawn elements |
| `openShadow` | `BOOL` | Enable/disable shadow effects |
| `drawStatus` | `DrawStatus` | Current drawing mode (Drawing/Editing/Texting) |

**Text and Stickers:**

| Property | Type | Description |
|----------|------|-------------|
| `fontName` | `NSString *` | Font name for text annotations |
| `tileEmojiText` | `NSString *` | Emoji character for emoji stickers |
| `tileAsset` | `PHAsset *` | Photo asset for image stickers |

**Internal Components:**

| Property | Type | Description |
|----------|------|-------------|
| `curves` | `NSMutableArray *` | Collection of drawn curves |
| `textView` | `LWScratchTextView *` | Text input component |
| `controlView` | `LWControlView *` | Control overlay for editing |

#### Methods

```objective-c
+ (instancetype)drawViewWithDelegate:(id<LWDrawViewProtocol>)delegate
```
Creates and initializes a drawing view with the specified delegate.

```objective-c
- (void)resetDrawing
```
Clears all content from the canvas and resets to initial state.

```objective-c
- (void)exitEditingOrTexting
```
Exits current editing or text input mode.

#### LWDrawViewProtocol

```objective-c
@protocol LWDrawViewProtocol <NSObject>
@optional
- (void)requestTileImageForAsset:(PHAsset *)tileAsset
                            size:(CGSize)size
                      completion:(void (^)(UIImage *, NSDictionary *))completion;
@end
```

---

### LWDrawBar

`LWDrawBar` provides a customizable toolbar with color picker and tool selection.

#### Methods

```objective-c
+ (LWDrawBar *)drawBarWithFrame:(CGRect)frame
```
Creates and initializes a drawing toolbar.

---

### Enumerations

#### DrawType

Defines the available drawing tool types:

```objective-c
typedef NS_OPTIONS(NSUInteger, DrawType) {
    Hand            = 1,        // Free brush drawing
    Erase           = 1 << 1,   // Eraser tool
    Line            = 1 << 2,   // Straight line
    LineArrow       = 1 << 3,   // Arrow
    Rectangle       = 1 << 4,   // Rectangle outline
    Oval            = 1 << 5,   // Oval/circle outline
    Text            = 1 << 6,   // Text annotation
    EmojiTile       = 1 << 7,   // Emoji sticker
    ImageTile       = 1 << 8,   // Image sticker
    RectangleDash   = 1 << 9,   // Dashed rectangle
    RectangleFill   = 1 << 10,  // Filled rectangle
    OvalDash        = 1 << 11,  // Dashed oval
    OvalFill        = 1 << 12,  // Filled oval
    LineDash        = 1 << 13,  // Dashed line
    CurveDash       = 1 << 14,  // Dashed curve
    ChinesePen      = 1 << 15,  // Chinese brush calligraphy
};
```

#### DrawStatus

Defines the current state of the drawing view:

```objective-c
typedef NS_OPTIONS(NSUInteger, DrawStatus) {
    Drawing = 1,   // Actively drawing new content
    Editing = 2,   // Editing existing elements
    Texting = 3,   // Text input mode
};
```

## Dependencies

LWDrawboard has minimal dependencies to ensure easy integration:

| Library | Purpose | Version |
|---------|---------|---------|
| [Masonry](https://github.com/SnapKit/Masonry) | Auto Layout DSL | >= 1.0 |
| [SDWebImage](https://github.com/SDWebImage/SDWebImage) | Async image loading and caching | >= 4.0 |

These dependencies are automatically managed when installing through CocoaPods or Carthage.

## FAQ

### How do I save drawings as images?

```objective-c
// Capture the drawing view as UIImage
UIGraphicsBeginImageContextWithOptions(drawView.bounds.size, NO, 0.0);
CGContextRef context = UIGraphicsGetCurrentContext();
[drawView.layer renderInContext:context];
UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

// Save to photo library (requires Photos framework permission)
UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
```

### Can I customize the color palette?

Yes! LWDrawBar includes 18 preset colors by default. To customize colors, modify the `DrawView_Color_Items` macro definition in the source code, or create your own custom toolbar.

### How do I add custom fonts?

1. Add your font file (`.ttf` or `.otf`) to your Xcode project
2. Add the font filename to your `Info.plist` under `Fonts provided by application`
3. Use the font's PostScript name:

```objective-c
drawView.fontName = @"YourCustomFont-Regular";
```

### How does the Chinese brush effect work?

The Chinese brush calligraphy effect is implemented through `AFBrushBoard`, which:
- Uses Bezier curve interpolation for smooth strokes
- Simulates brush pressure based on touch velocity
- Applies dynamic width variation to mimic real brush behavior
- Renders with anti-aliasing for authentic appearance

### Does LWDrawboard support undo/redo?

Yes! The library includes built-in undo/redo functionality through the curves management system. Each drawing action is recorded as a separate curve object that can be manipulated.

### Can I use LWDrawboard in Swift projects?

Absolutely! LWDrawboard is written in Objective-C but is fully compatible with Swift through the Objective-C bridging mechanism. Simply import the module:

```swift
import LWDrawboard
```

### How do I handle memory management for large canvases?

LWDrawboard is optimized for performance, but for very large canvases or long drawing sessions:
- Use `resetDrawing` periodically to clear the canvas
- Export intermediate results and start fresh
- Consider rendering to a lower resolution for preview purposes
- Monitor memory usage in Instruments

## Contributing

We welcome contributions to LWDrawboard! Here's how you can help:

### Reporting Issues

- Check existing issues before creating a new one
- Include detailed reproduction steps
- Provide iOS version, Xcode version, and LWDrawboard version
- Include code snippets or screenshots when applicable

### Submitting Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes and test thoroughly
4. Commit your changes (`git commit -m 'Add amazing feature'`)
5. Push to your branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request with a clear description

### Development Guidelines

- Follow existing code style and conventions
- Add comments for complex logic
- Update documentation for API changes
- Test on multiple iOS versions when possible

## Author

**luowei**
- Email: luowei@wodedata.com
- GitHub: [@luowei](https://github.com/luowei)

## License

LWDrawboard is available under the MIT License. See the [LICENSE](LICENSE) file for details.

### MIT License Summary

```
Copyright (c) 2017 luowei

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
```

---

## Acknowledgments

Special thanks to all contributors who have helped improve LWDrawboard.

## Links

- [CocoaPods](https://cocoapods.org/pods/LWDrawboard)
- [GitHub Repository](https://github.com/luowei/LWDrawboard)
- [Issue Tracker](https://github.com/luowei/LWDrawboard/issues)
- [中文文档](./README_ZH.md)
