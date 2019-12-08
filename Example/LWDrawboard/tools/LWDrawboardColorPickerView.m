//
// Created by Luo Wei on 2017/5/13.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <libColorPicker/RSColorPickerView.h>
#import <libColorPicker/RSOpacitySlider.h>
#import <libColorPicker/RSBrightnessSlider.h>
#import "LWDrawboardColorPickerView.h"
#import "LWCategories.h"
#import "LWDrawExtentions.h"
#import <Masonry/Masonry.h>


@interface LWDrawboardColorPickerView () <RSColorPickerViewDelegate>

@property(nonatomic, strong) UIView *topLine;
@end

@implementation LWDrawboardColorPickerView {
}

+ (LWDrawboardColorPickerView *)colorPickerWithFrame:(CGRect)frame delegate:(id <LWDrawboardColorPickerViewDelegate>)delegate {
    LWDrawboardColorPickerView *dbColorPicker = [[LWDrawboardColorPickerView alloc] initWithFrame:frame];
    dbColorPicker.delegate = delegate;
    return dbColorPicker;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedColor = [UIColor clearColor];


        self.currentColorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.currentColorBtn];
        [self.currentColorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(40);
        }];
        [self.currentColorBtn setHitTestEdgeInsets:UIEdgeInsetsMake(-2, -5, -5, -2)];
        [self.currentColorBtn setImage:[UIImage imageNamed:@"whiteColor"] forState:UIControlStateNormal];
        [self.currentColorBtn addTarget:self action:@selector(currentColorBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];


        self.colorPickerView = [[RSColorPickerView alloc] initWithFrame:CGRectMake(0, 0, 146, 24)];
        [self addSubview:self.colorPickerView];
        [self.colorPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.currentColorBtn.mas_right).offset(3);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(24);
            make.width.mas_greaterThanOrEqualTo(120);
        }];
        self.colorPickerView.delegate = self;


        self.brightnessSlider = [RSBrightnessSlider new];
        [self addSubview:self.brightnessSlider];
        [self.brightnessSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.colorPickerView.mas_right).offset(6);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(24);
            make.width.mas_greaterThanOrEqualTo(80);
        }];
        self.brightnessSlider.value = 1.0;
        [self.brightnessSlider addTarget:self action:@selector(brightnessSlideChanged:) forControlEvents:UIControlEventValueChanged];


        self.opacitySlider = [RSOpacitySlider new];
        [self addSubview:self.opacitySlider];
        [self.opacitySlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.brightnessSlider.mas_right).offset(6);
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-6);
            make.height.mas_equalTo(24);
            make.width.equalTo(self.brightnessSlider);
        }];
        self.opacitySlider.value = 1.0;
        [self.opacitySlider addTarget:self action:@selector(opacitySliderChanged:) forControlEvents:UIControlEventValueChanged];



        self.topLine = [UIView new];
        [self addSubview:self.topLine];
        self.topLine.backgroundColor = [UIColor lightGrayColor];
        [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];


    }

    return self;
}


- (void)currentColorBtnTouchUpInside:(UIButton *)btn {
    [btn setImage:[UIImage imageNamed:@"whiteColor"] forState:UIControlStateNormal];

    if ([self.delegate respondsToSelector:@selector(colorPickerView:pickedColor:)]) {
        [self.delegate colorPickerView:self pickedColor:[UIColor whiteColor]];
    }
}

- (void)brightnessSlideChanged:(RSBrightnessSlider *)slider {
    if ((int) (slider.value * 100) % 4 == 0) {
        [slider vibrate];
    }
    [self.colorPickerView setBrightness:slider.value];
}

- (void)opacitySliderChanged:(RSOpacitySlider *)slider {
    if ((int) (slider.value * 100) % 4 == 0) {
        [slider vibrate];
    }
    [self.colorPickerView setOpacity:slider.value];
}


- (void)colorPickerDidChangeSelection:(RSColorPickerView *)colorPicker {

    UIColor *selectedColor = [colorPicker selectionColor];
//    CGFloat alpha = CGColorGetAlpha(self.selectedColor.CGColor);
    CGFloat hue = 0, saturation = 0, brightness = 0, alpha = 0;
    [selectedColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];

    if ((int) (hue * 100) % 4 == 0) {
        [colorPicker vibrate];
    }

    self.selectedColor = selectedColor;
    if (alpha > 0.1) {
        UIImage *colorImage = [UIImage circleWithColor:self.selectedColor size:CGSizeMake(30, 30)];
        [self.currentColorBtn setImage:colorImage forState:UIControlStateNormal];
    }

    self.opacitySlider.value = alpha;
    self.brightnessSlider.value = brightness;

    if ([self.delegate respondsToSelector:@selector(colorPickerView:pickedColor:)]) {
        [self.delegate colorPickerView:self pickedColor:self.selectedColor];
    }
}


@end
