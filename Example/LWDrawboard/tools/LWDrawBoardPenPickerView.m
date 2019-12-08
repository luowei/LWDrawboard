//
// Created by Luo Wei on 2017/5/13.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <libColorPicker/RSColorPickerView.h>
#import <libColorPicker/RSBrightnessSlider.h>
#import <Masonry/Masonry.h>
#import "LWDrawBoardPenPickerView.h"
#import "LWDrawExtentions.h"
#import "LWCategories.h"

@interface LWDrawBoardPenPickerView () <RSColorPickerViewDelegate>

@property(nonatomic, strong) UIView *topLine;
@end

@implementation LWDrawBoardPenPickerView {

}

+ (LWDrawBoardPenPickerView *)penPickerWithFrame:(CGRect)frame delegate:(id<LWDrawBoardPenPickerViewDelegate>)delegate{
    LWDrawBoardPenPickerView *penPickerView = [[LWDrawBoardPenPickerView alloc] initWithFrame:frame];
    penPickerView.delegate = delegate;
    return penPickerView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedColor = [UIColor blackColor];

        self.currentColorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.currentColorBtn];
        [self.currentColorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(40);
        }];
        [self.currentColorBtn setImage:[UIImage imageNamed:@"blackColor"] forState:UIControlStateNormal];
        [self.currentColorBtn setHitTestEdgeInsets:UIEdgeInsetsMake(-2, -5, -5, -2)];
        [self.currentColorBtn addTarget:self action:@selector(currentColorBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];


        self.colorPickerView = [[RSColorPickerView alloc] initWithFrame:CGRectMake(0, 0, 146, 24)];
        [self addSubview:self.colorPickerView];
        [self.colorPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.currentColorBtn.mas_right).offset(3);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(24);
            make.width.mas_greaterThanOrEqualTo(146);
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



        self.penSizeSlider = [UISlider new];
        [self addSubview:self.penSizeSlider];
        [self.penSizeSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.brightnessSlider.mas_right).offset(6);
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-6);
            make.height.mas_equalTo(24);
            make.width.equalTo(self.brightnessSlider);
        }];
        self.penSizeSlider.layer.cornerRadius = 3;
        self.penSizeSlider.value = 0.65;
        UIImage *penColorImg = [UIImage circleWithColor:[UIColor lightGrayColor] size:CGSizeMake(16, 16)];
        [self.penSizeSlider setThumbImage:penColorImg forState:UIControlStateNormal];
        [self.penSizeSlider addTarget:self action:@selector(penSizeSliderChanged:) forControlEvents:UIControlEventValueChanged];



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
    self.selectedColor = [UIColor blackColor];
    [btn setImage:[UIImage imageNamed:@"blackColor"] forState:UIControlStateNormal];

    if([self.delegate respondsToSelector:@selector(pickerView:pickedPenColor:)]){
        [self.delegate pickerView:self pickedPenColor:self.selectedColor];
    }
}

- (void)brightnessSlideChanged:(RSBrightnessSlider *)slider {
    if ((int) (slider.value * 100) % 4 == 0) {
        [slider vibrate];
    }
    [self.colorPickerView setBrightness:slider.value];
}

- (void)penSizeSliderChanged:(UISlider *)slider {
    if ((int) (slider.value * 100) % 4 == 0) {
        [slider vibrate];
    }

    if([self.delegate respondsToSelector:@selector(pickerView:pickedPenWidth:)]){
        [self.delegate pickerView:self pickedPenWidth:slider.value * 20];
    }
}


- (void)colorPickerDidChangeSelection:(RSColorPickerView *)colorPicker {
    UIColor *selectedColor = [colorPicker selectionColor];

    CGFloat hue = 0, saturation = 0, brightness = 0, alpha = 0;
    [selectedColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    if ((int) (hue * 100) % 4 == 0) {
        [colorPicker vibrate];
    }
    self.selectedColor = selectedColor;

    UIImage *colorImage = [UIImage circleWithColor:self.selectedColor size:CGSizeMake(30, 30)];
    [self.currentColorBtn setImage:colorImage forState:UIControlStateNormal];

    if([self.delegate respondsToSelector:@selector(pickerView:pickedPenColor:)]){
        [self.delegate pickerView:self pickedPenColor:self.selectedColor];
    }
}


@end