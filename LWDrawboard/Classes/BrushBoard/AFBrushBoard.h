//
//  AFBrushBoard.h
//  AFBrushBoard
//
//  Created by Ordinary on 16/3/24.
//  Copyright © 2016年 Ordinary. All rights reserved.
//
// 毛笔字效果笔刷板
// Swift版本：https://github.com/chu888chu888/IOS-AFBrushBoard

#import <UIKit/UIKit.h>

#define Default_PenWidth 13

@interface AFBrushBoard : UIImageView

@property(nonatomic, strong) UIColor *penColor;

@property(nonatomic) CGFloat penWidth;

- (void)cleanDrawImage;

@end
