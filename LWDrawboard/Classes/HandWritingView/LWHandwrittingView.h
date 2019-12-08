//
// Created by Luo Wei on 2017/3/25.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

//#ifdef DEBUG
//#define HandwritingLog(fmt, ...) NSLog((@"%s [Line %d]\n" fmt @"\n\n\n"), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//#else
//#define HandwritingLog(...)
//#endif

@protocol LWHandwrittingViewProtocol<NSObject>

@optional
- (void)touchMovedWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints;
- (void)touchMoveEndWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints;
- (void)touchCancelledWithPathPoints:(NSMutableArray *)pathPoints;
@end


@interface LWHandwrittingView : UIView

@property(nonatomic, weak) id<LWHandwrittingViewProtocol> delegate;
@property(nonatomic, strong) NSMutableArray *pathes;

@property(nonatomic) CGFloat lineWidth;

@property(nonatomic, strong) UIColor *lineColor;

+(instancetype)handwrittingViewWithFrame:(CGRect)frame delegate:(id<LWHandwrittingViewProtocol>)delegate;

@end