//
// Created by Luo Wei on 2017/5/13.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSBrightnessSlider;
@class RSColorPickerView;
@class LWDrawBoardPenPickerView;

@protocol LWDrawBoardPenPickerViewDelegate<NSObject>

@optional
- (void)pickerView:(LWDrawBoardPenPickerView *)pickerView pickedPenColor:(UIColor *)color;
- (void)pickerView:(LWDrawBoardPenPickerView *)pickerView pickedPenWidth:(CGFloat)penWidth;
@end

@interface LWDrawBoardPenPickerView : UIView

@property (nonatomic, weak) id<LWDrawBoardPenPickerViewDelegate> delegate;

@property (nonatomic, strong) UIButton *currentColorBtn;
@property (nonatomic, strong) RSColorPickerView *colorPickerView;
@property (nonatomic, strong) RSBrightnessSlider *brightnessSlider;
@property (nonatomic, strong) UISlider *penSizeSlider;

@property(nonatomic, strong) UIColor *selectedColor;

+ (LWDrawBoardPenPickerView *)penPickerWithFrame:(CGRect)frame delegate:(id<LWDrawBoardPenPickerViewDelegate>)delegate;

@end