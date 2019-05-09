//
// Created by Luo Wei on 2017/5/13.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSBrightnessSlider;
@class RSOpacitySlider;
@class RSColorPickerView;
@class LWDrawboardColorPickerView;

@protocol LWDrawboardColorPickerViewDelegate<NSObject>

@optional
- (void)colorPickerView:(LWDrawboardColorPickerView *)colorPickerView pickedColor:(UIColor *)color;
@end

@interface LWDrawboardColorPickerView : UIView

@property (nonatomic, weak) id<LWDrawboardColorPickerViewDelegate> delegate;


@property (nonatomic, strong) UIButton *currentColorBtn;
@property (nonatomic, strong) RSColorPickerView *colorPickerView;
@property (nonatomic, strong) RSBrightnessSlider *brightnessSlider;
@property (nonatomic, strong) RSOpacitySlider *opacitySlider;

@property(nonatomic, strong) UIColor *selectedColor;

+ (LWDrawboardColorPickerView *)colorPickerWithFrame:(CGRect)frame delegate:(id<LWDrawboardColorPickerViewDelegate>)delegate;

@end