//
// Created by luowei on 16/10/8.
// Copyright (c) 2016 wodedata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PHAsset;


//绘制笔类型
typedef NS_OPTIONS(NSUInteger, DrawType) {
    Hand = 1,
    Erase = 1 << 1,
    Line = 1 << 2,
    LineArrow = 1 << 3,
    Rectangle = 1 << 4,
    Oval = 1 << 5,
    Text = 1 << 6,
    EmojiTile = 1 << 7,
    ImageTile = 1 << 8,
    RectangleDash = 1 << 9,
    RectangleFill = 1 << 10,
    OvalDash = 1 << 11,
    OvalFill = 1 << 12,
    LineDash = 1 << 13,
    CurveDash = 1 << 14,
    ChinesePen = 1 << 15,
};

typedef NS_OPTIONS(NSUInteger, DrawStatus){
    Drawing = 1,   //绘制模式
    Editing = 2,   //编辑模式
    Texting = 3,   //文本输入模式
};

@interface LWDrafter : NSObject

@property (nonatomic, strong) NSMutableArray *pointArr;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic,assign) DrawType drawType;


@property(nonatomic, copy) NSString *tileEmojiText;
@property(nonatomic, strong) PHAsset *tileAsset;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, copy) NSString *fontName;
@property(nonatomic, assign) CGRect rect;
@property(nonatomic) BOOL isTexting;
@property(nonatomic) BOOL isEditing;
@property(nonatomic) BOOL isNew;

@property(nonatomic) CGRect pathBounds;
@property(nonatomic) CGFloat rotateAngle;
@property(nonatomic) CGRect scaleRect;
@property(nonatomic) CGPoint movePoint;

//EmojiTile/ImageTile
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSNumber *> *rotateAngleDict; //{"x,y":"45"}

@property(nonatomic, strong) NSShadow *shadow;


@property(nonatomic) BOOL openShadow;

-(UIColor *)color;
-(CGSize)burshSize;

@end