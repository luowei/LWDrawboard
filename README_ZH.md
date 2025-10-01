# LWDrawboard

[![CI Status](https://img.shields.io/travis/luowei/LWDrawboard.svg?style=flat)](https://travis-ci.org/luowei/LWDrawboard)
[![Version](https://img.shields.io/cocoapods/v/LWDrawboard.svg?style=flat)](https://cocoapods.org/pods/LWDrawboard)
[![License](https://img.shields.io/cocoapods/l/LWDrawboard.svg?style=flat)](https://cocoapods.org/pods/LWDrawboard)
[![Platform](https://img.shields.io/cocoapods/p/LWDrawboard.svg?style=flat)](https://cocoapods.org/pods/LWDrawboard)

## 简介

LWDrawboard 是一个功能强大的 iOS 画板和涂鸦板库，支持自定义笔触大小和颜色。它提供了丰富的绘图工具和功能，包括：

- 可自定义笔触大小和颜色的自由绘画
- 绘制矩形、圆形、多边形、箭头等几何图形
- 文字输入和编辑，支持多种字体样式
- 马赛克效果
- 图片裁剪功能
- 毛笔字效果笔刷
- 手写输入支持
- 表情符号和图片贴纸
- 橡皮擦功能
- 阴影效果支持

## 功能特性

### 核心功能

- **多种绘图工具**
  - 自由画笔（Hand）
  - 橡皮擦（Erase）
  - 直线（Line）
  - 箭头（LineArrow）
  - 矩形（Rectangle、RectangleDash、RectangleFill）
  - 圆形/椭圆（Oval、OvalDash、OvalFill）
  - 虚线（LineDash、CurveDash）
  - 毛笔（ChinesePen）

- **文本和贴纸**
  - 文字输入和编辑（Text）
  - 多种字体支持（包括 Helvetica、PingFang、STFangsong 等）
  - 表情符号贴纸（EmojiTile）
  - 图片贴纸（ImageTile）

- **高级功能**
  - 可调节笔触宽度（5-13pt）
  - 自定义颜色选择器（18 种预设颜色）
  - 背景图片和背景颜色设置
  - 阴影效果开关
  - 图形旋转和缩放
  - 撤销/重做功能
  - 保存为图片

### 专业特性

- **AFBrushBoard** - 毛笔字效果笔刷板，实现真实的毛笔书写效果
- **LWHandwrittingView** - 手写输入视图，支持手写识别和路径追踪
- **LWDrawView** - 主绘图视图，支持多种绘图模式和编辑功能

## 系统要求

- iOS 8.0 或更高版本
- Xcode 9.0+
- Swift 4.0+ / Objective-C

## 安装

### CocoaPods

LWDrawboard 可以通过 [CocoaPods](https://cocoapods.org) 进行安装。在你的 Podfile 中添加以下内容：

```ruby
pod 'LWDrawboard'
```

然后运行：

```bash
pod install
```

### Carthage

在你的 Cartfile 中添加以下内容：

```ruby
github "luowei/LWDrawboard"
```

然后运行：

```bash
carthage update
```

## 使用方法

### 示例项目

要运行示例项目，请先克隆仓库，然后在 Example 目录下运行 `pod install`。

示例项目包含了两个主要的使用示例：
- `LWBrushBoardViewController` - 演示毛笔板的使用
- `LWHandwrittingViewController` - 演示手写输入的使用

### 基本使用

#### 1. 创建毛笔画板（AFBrushBoard）

```objective-c
#import <LWDrawboard/AFBrushBoard.h>

// 创建毛笔画板
AFBrushBoard *brushBoard = [[AFBrushBoard alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];

// 设置笔触颜色
brushBoard.penColor = [UIColor blackColor];

// 设置笔触宽度（默认为 13）
brushBoard.penWidth = 10;

// 添加到视图
[self.view addSubview:brushBoard];

// 清空画板
[brushBoard cleanDrawImage];
```

#### 2. 创建手写输入视图（LWHandwrittingView）

```objective-c
#import <LWDrawboard/LWHandwrittingView.h>

// 创建手写输入视图
LWHandwrittingView *handwritingView = [LWHandwrittingView handwrittingViewWithFrame:self.view.bounds
                                                                             delegate:self];

// 设置线条颜色
handwritingView.lineColor = [UIColor blueColor];

// 设置线条宽度
handwritingView.lineWidth = 2.0;

// 添加到视图
[self.view addSubview:handwritingView];
```

实现代理方法：

```objective-c
#pragma mark - LWHandwrittingViewProtocol

- (void)touchMovedWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints {
    // 触摸移动时的回调
    NSLog(@"Touch moved at: %@", NSStringFromCGPoint(touchPoint));
}

- (void)touchMoveEndWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints {
    // 触摸结束时的回调
    NSLog(@"Touch ended at: %@", NSStringFromCGPoint(touchPoint));
}

- (void)touchCancelledWithPathPoints:(NSMutableArray *)pathPoints {
    // 触摸取消时的回调
    NSLog(@"Touch cancelled");
}
```

#### 3. 创建完整的绘图视图（LWDrawView）

```objective-c
#import <LWDrawboard/LWDrawView.h>
#import <LWDrawboard/LWDrawBar.h>

// 创建绘图视图
LWDrawView *drawView = [LWDrawView drawViewWithDelegate:self];
drawView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 60);

// 设置背景颜色
drawView.backgroundFillColor = [UIColor whiteColor];

// 设置绘图类型
drawView.drawType = Hand; // 自由画笔

// 设置画笔颜色
drawView.freeInkColor = [UIColor blackColor];

// 设置画笔线宽
drawView.freeInkLinewidth = 3.0;

// 开启阴影效果
drawView.openShadow = YES;

// 启用编辑功能
drawView.enableEdit = YES;

// 添加到视图
[self.view addSubview:drawView];

// 创建工具栏
LWDrawBar *drawBar = [LWDrawBar drawBarWithFrame:CGRectMake(0, self.view.bounds.size.height - 60,
                                                              self.view.bounds.size.width, 60)];
[self.view addSubview:drawBar];
```

### 高级功能

#### 切换绘图工具

```objective-c
// 切换为橡皮擦模式
drawView.drawType = Erase;

// 切换为矩形工具
drawView.drawType = Rectangle;

// 切换为圆形工具
drawView.drawType = Oval;

// 切换为箭头工具
drawView.drawType = LineArrow;

// 切换为文字工具
drawView.drawType = Text;

// 切换为毛笔工具
drawView.drawType = ChinesePen;
drawView.chinesePenWidth = 13.0;
```

#### 重置和清空画板

```objective-c
// 重置画板（清空所有内容）
[drawView resetDrawing];

// 退出编辑或文本输入状态
[drawView exitEditingOrTexting];
```

#### 设置字体

```objective-c
// 设置文字字体
drawView.fontName = @"PingFangSC-Regular";
```

#### 添加表情符号或图片贴纸

```objective-c
// 添加表情符号
drawView.drawType = EmojiTile;
drawView.tileEmojiText = @"😀";

// 添加图片贴纸（需要实现代理方法）
drawView.drawType = ImageTile;
drawView.tileAsset = photoAsset; // PHAsset 对象
```

实现图片请求代理方法：

```objective-c
#pragma mark - LWDrawViewProtocol

- (void)requestTileImageForAsset:(PHAsset *)tileAsset
                            size:(CGSize)size
                      completion:(void (^)(UIImage *, NSDictionary *))completion {
    // 从相册获取图片
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

## API 文档

### AFBrushBoard

毛笔字效果笔刷板。

#### 属性

- `penColor` (UIColor *) - 笔触颜色
- `penWidth` (CGFloat) - 笔触宽度，默认值为 13

#### 方法

- `- (void)cleanDrawImage` - 清空画板内容

---

### LWHandwrittingView

手写输入视图，支持手写识别和路径追踪。

#### 属性

- `delegate` (id<LWHandwrittingViewProtocol>) - 代理对象
- `pathes` (NSMutableArray *) - 绘制路径数组
- `lineWidth` (CGFloat) - 线条宽度
- `lineColor` (UIColor *) - 线条颜色

#### 方法

- `+ (instancetype)handwrittingViewWithFrame:(CGRect)frame delegate:(id<LWHandwrittingViewProtocol>)delegate` - 创建手写输入视图

#### 代理方法（LWHandwrittingViewProtocol）

```objective-c
@optional
- (void)touchMovedWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints;
- (void)touchMoveEndWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints;
- (void)touchCancelledWithPathPoints:(NSMutableArray *)pathPoints;
```

---

### LWDrawView

主绘图视图，提供完整的绘图和编辑功能。

#### 属性

##### 绘图设置
- `drawType` (DrawType) - 当前绘图工具类型
- `freeInkColor` (UIColor *) - 自由画笔颜色
- `freeInkLinewidth` (CGFloat) - 自由画笔线宽
- `chinesePenWidth` (CGFloat) - 毛笔笔宽

##### 背景设置
- `backgroundImage` (UIImage *) - 背景图片
- `backgroundFillColor` (UIColor *) - 背景颜色

##### 功能开关
- `enableEdit` (BOOL) - 是否启用编辑功能
- `openShadow` (BOOL) - 是否开启阴影效果
- `drawStatus` (DrawStatus) - 当前绘图状态（Drawing/Editing/Texting）

##### 文字和贴纸
- `fontName` (NSString *) - 文字字体名称
- `tileEmojiText` (NSString *) - 表情符号文本
- `tileAsset` (PHAsset *) - 图片资源

##### 内部组件
- `curves` (NSMutableArray *) - 曲线集合
- `textView` (LWScratchTextView *) - 文本输入框
- `controlView` (LWControlView *) - 控制框

#### 方法

- `+ (instancetype)drawViewWithDelegate:(id<LWDrawViewProtocol>)delegate` - 创建绘图视图
- `- (void)resetDrawing` - 重置画板（清空所有内容）
- `- (void)exitEditingOrTexting` - 退出编辑或文本输入状态

#### 代理方法（LWDrawViewProtocol）

```objective-c
@optional
- (void)requestTileImageForAsset:(PHAsset *)tileAsset
                            size:(CGSize)size
                      completion:(void (^)(UIImage *, NSDictionary *))completion;
```

---

### LWDrawBar

绘图工具栏。

#### 方法

- `+ (LWDrawBar *)drawBarWithFrame:(CGRect)frame` - 创建工具栏

---

### DrawType 枚举

绘制工具类型：

```objective-c
typedef NS_OPTIONS(NSUInteger, DrawType) {
    Hand = 1,                // 自由画笔
    Erase = 1 << 1,         // 橡皮擦
    Line = 1 << 2,          // 直线
    LineArrow = 1 << 3,     // 箭头
    Rectangle = 1 << 4,     // 矩形
    Oval = 1 << 5,          // 椭圆
    Text = 1 << 6,          // 文字
    EmojiTile = 1 << 7,     // 表情符号贴纸
    ImageTile = 1 << 8,     // 图片贴纸
    RectangleDash = 1 << 9, // 虚线矩形
    RectangleFill = 1 << 10,// 填充矩形
    OvalDash = 1 << 11,     // 虚线椭圆
    OvalFill = 1 << 12,     // 填充椭圆
    LineDash = 1 << 13,     // 虚线
    CurveDash = 1 << 14,    // 虚线曲线
    ChinesePen = 1 << 15,   // 毛笔
};
```

### DrawStatus 枚举

绘图状态：

```objective-c
typedef NS_OPTIONS(NSUInteger, DrawStatus) {
    Drawing = 1,   // 绘制模式
    Editing = 2,   // 编辑模式
    Texting = 3,   // 文本输入模式
};
```

## 依赖库

LWDrawboard 依赖以下第三方库：

- [Masonry](https://github.com/SnapKit/Masonry) - 自动布局库
- [SDWebImage](https://github.com/SDWebImage/SDWebImage) - 图片加载和缓存库

这些依赖会在通过 CocoaPods 或 Carthage 安装时自动包含。

## 常见问题

### 1. 如何保存画板内容为图片？

```objective-c
// 将视图内容保存为图片
UIGraphicsBeginImageContextWithOptions(drawView.bounds.size, NO, 0.0);
[drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

// 保存到相册
UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
```

### 2. 如何自定义颜色选择器？

LWDrawBar 中已经内置了颜色选择器，包含 18 种预设颜色。如需自定义，可以修改 `DrawView_Color_Items` 宏定义中的颜色值。

### 3. 如何添加自定义字体？

将字体文件添加到项目中，并在 Info.plist 中注册。然后使用字体名称：

```objective-c
drawView.fontName = @"YourCustomFont-Regular";
```

### 4. 毛笔效果如何实现？

毛笔效果是通过 AFBrushBoard 类实现的，它基于贝塞尔曲线和触摸压力模拟真实的毛笔书写效果。

## 贡献

欢迎提交 Issue 和 Pull Request！

## 作者

luowei, luowei@wodedata.com

## 许可证

LWDrawboard 基于 MIT 许可证开源。详细信息请查看 [LICENSE](LICENSE) 文件。

---

## English Documentation

For English documentation, please refer to [README.md](README.md).
