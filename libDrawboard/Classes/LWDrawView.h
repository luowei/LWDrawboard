//
//  LWDrawView.h
//  LWInputMethod
//
//  Created by luowei on 16/6/26.
//  Copyright © 2016年 MerryUnion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWDrafter.h"

// 最小/大宽度
#define kWIDTH_MIN 5
#define kWIDTH_MAX 13

@class LWControlImgV;
@class LWControlView;
@class PHAsset;
@class LWScratchTextView;
@class LWDrawView;

@protocol LWDrawViewProtocol<NSObject>

@optional
- (void)requestTileImageForAsset:(PHAsset *)tileAsset size:(CGSize)size completion:(void (^)(UIImage *, NSDictionary *))completion;

@end

@interface LWDrawView : UIView <UITextViewDelegate>

@property (nonatomic, weak) id<LWDrawViewProtocol> delegate;

//是否橡皮擦模式
@property (nonatomic,assign) DrawType drawType;

//自由画笔颜色
@property(nonatomic, strong) UIColor *freeInkColor;
//自由画笔线宽
@property(nonatomic, assign) CGFloat freeInkLinewidth;

//曲线集
@property (nonatomic, strong) NSMutableArray *curves;

@property(nonatomic, copy) NSString *tileEmojiText;
@property(nonatomic, strong) PHAsset *tileAsset;

@property(nonatomic, copy) NSString *fontName;

@property(nonatomic, strong) LWScratchTextView *textView;
@property(nonatomic, strong) NSLayoutConstraint *textVConstX;
@property(nonatomic, strong) NSLayoutConstraint *textVConstY;
@property(nonatomic, strong) NSLayoutConstraint *textVWidth;
@property(nonatomic, strong) NSLayoutConstraint *textVHeight;

@property(nonatomic, strong) LWControlView *controlView;
@property(nonatomic, strong) NSLayoutConstraint *controlViewConstX;
@property(nonatomic, strong) NSLayoutConstraint *controlViewConstY;
@property(nonatomic, strong) NSLayoutConstraint *controlViewWidth;
@property(nonatomic, strong) NSLayoutConstraint *controlViewHeight;

@property(nonatomic, strong) LWControlImgV *control;
@property(nonatomic, strong) NSLayoutConstraint *controlConstX;
@property(nonatomic, strong) NSLayoutConstraint *controlConstY;

@property(nonatomic) DrawStatus drawStatus;
@property(nonatomic) BOOL enableEdit;

@property(nonatomic) BOOL openShadow;

//背景图片
@property(nonatomic) UIImage *backgroundImage;
//背景颜色
@property(nonatomic, strong) UIColor *backgroundFillColor;

//毛笔当前笔宽
@property (nonatomic, assign) CGFloat chinesePenWidth;

+(instancetype)drawViewWithDelegate:(id<LWDrawViewProtocol>)delegate;

//画板重置
-(void) resetDrawing;

//退出编辑以及文本输入状态
-(void)exitEditingOrTexting;

@end


//文本输入框
@interface LWScratchTextView : UITextView
@end


//控制按钮
@interface LWControlImgV : UIImageView
@end


//控制框
@interface LWControlView : UIView

@property(nonatomic, strong) LWControlImgV *control;
@property(nonatomic, strong) LWControlImgV *rotate;

@end