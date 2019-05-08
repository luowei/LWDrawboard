//
// Created by luowei on 16/10/11.
// Copyright (c) 2016 wodedata. All rights reserved.
//

#ifdef DEBUG
#define DrawLog(fmt, ...) NSLog((@"%s [Line %d]\n" fmt @"\n\n\n"), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DrawLog(...)
#endif

#define LWDrawboardBundle(obj)  ([NSBundle bundleWithPath:[[NSBundle bundleForClass:[obj class]] pathForResource:@"libDrawboard" ofType:@"bundle"]] ?: ([NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"libDrawboard " ofType:@"bundle"]] ?: [NSBundle mainBundle]))
#define UIImageWithName(name,obj) ([UIImage imageNamed:name inBundle:LWDrawboardBundle(obj) compatibleWithTraitCollection:nil])

//#define HexRGBAColor(hexValue, alphaValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue]
//#define HexRGBColor(hexValue) HexRGBAColor(hexValue, 1)

@interface UIBezierPath(Rotate)

//旋转UIBzierPath
- (void)rotateDegree:(CGFloat)degree;

//缩放UIBezierPath，宽度缩放比scaleW，高度缩放比scaleH
-(void)scaleWidth:(CGFloat)scaleW scaleHeight:(CGFloat)scaleH;

//按中心点移动缩放UIBezierPath
-(void)moveCenterToPoint:(CGPoint)destPoint;

@end


@interface NSString (UIImage)

- (UIImage *)image:(CGSize)size;

@end


@interface UIColor (Ext)

//颜色反转
- (UIColor *)reverseColor;

//是否是亮色
- (BOOL)isLight;

+ (UIColor *)colorWithHexString:(NSString *)hex;

@end



@interface UIView (Extension)

//获得指class类型的父视图
- (id)draw_superViewWithClass:(Class)clazz;

- (UIImage *)snapshotImage;
//截取 UIView 指定 rect 的图像
- (UIImage *)snapshotImageInRect:(CGRect)rect;

@end



@interface UIImage (Ext)

//把字符串依据指定的字体属性及大小转换成图片
+ (UIImage *)imageFromString:(NSString *)string attributes:(NSDictionary *)attributes size:(CGSize)size;

//根据颜色与矩形区生成一张图片
+ (UIImage *)imageFromColor:(UIColor *)color withRect:(CGRect)rect;

//在指定大小的绘图区域内,将img2合成到img1上
+ (UIImage *)addImageToImage:(UIImage *)img withImage2:(UIImage *)img2
                     andRect:(CGRect)cropRect withImageSize:(CGSize)size;

@end