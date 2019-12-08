//
// Created by luowei on 2019/5/9.
// Copyright (c) 2019 luowei. All rights reserved.
//

#import "LWBrushBoardViewController.h"
#import "View+MASAdditions.h"
#import "LWDrawboardColorPickerView.h"
#import "LWDrawBoardPenPickerView.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <LWDrawboard/AFBrushBoard.h>
#import <LWDrawboard/LWDrawExtentions.h>


@interface LWBrushBoardViewController()<LWDrawboardColorPickerViewDelegate,LWDrawBoardPenPickerViewDelegate>

@property (nonatomic, strong) UIView *drawBoard;
@property (nonatomic, strong) UIImageView *brushBackgroundView;
@property (nonatomic, strong) AFBrushBoard *brushBoard;

@property (nonatomic, strong) UIView *drawBar;
@property (nonatomic, strong) UIButton *colorWheelBtn;
@property (nonatomic, strong) UIButton *colorPenBtn;
@property (nonatomic, strong) UIButton *drawClearBtn;
@property (nonatomic, strong) UIButton *drawSaveBtn;

@property(nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) LWDrawboardColorPickerView *drawColorSelector;
@property (nonatomic, strong) LWDrawBoardPenPickerView *drawPenSelector;

@end

@implementation LWBrushBoardViewController {
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    //画板
    self.drawBoard = [UIView new];
    [self.view addSubview:self.drawBoard];
    [self.drawBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 30, 0));
    }];

    self.brushBackgroundView = [UIImageView new];
    [self.drawBoard addSubview:self.brushBackgroundView];
    [self.brushBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.drawBoard).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.brushBackgroundView.contentMode = UIViewContentModeScaleToFill;
    self.brushBackgroundView.backgroundColor = [UIColor clearColor];

    self.brushBoard = [AFBrushBoard new];
    [self.drawBoard addSubview:self.brushBoard];
    [self.brushBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.drawBoard).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.brushBoard.backgroundColor = [UIColor clearColor];
    self.brushBoard.penColor = [UIColor blackColor];


    //工具条
    self.drawBar = [UIView new];
    [self.view addSubview:self.drawBar];
    [self.drawBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];

    self.colorWheelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.drawBar addSubview:self.colorWheelBtn];
    [self.colorWheelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.drawBar).offset(15);
        make.centerY.equalTo(self.drawBar);
        make.width.height.mas_equalTo(30);
    }];
    [self.colorWheelBtn setImage:[UIImage imageNamed:@"colorWheel"] forState:UIControlStateNormal];
    [self.colorWheelBtn setImage:[UIImage imageNamed:@"colorWheel_selected"] forState:UIControlStateSelected];
    [self.colorWheelBtn addTarget:self action:@selector(colorWheelBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];


    self.colorPenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.drawBar addSubview:self.colorPenBtn];
    [self.colorPenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.drawBar).offset(110);
        make.centerY.equalTo(self.drawBar);
        make.width.height.mas_equalTo(30);
    }];
    [self.colorPenBtn setImage:[UIImage imageNamed:@"drawColorPen"] forState:UIControlStateNormal];
    [self.colorPenBtn addTarget:self action:@selector(colorPenBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];


    self.drawClearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.drawBar addSubview:self.drawClearBtn];
    [self.drawClearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.drawBar).offset(220);
        make.centerY.equalTo(self.drawBar);
        make.width.height.mas_equalTo(30);
    }];
    [self.drawClearBtn setImage:[UIImage imageNamed:@"drawClear"] forState:UIControlStateNormal];
    [self.drawClearBtn addTarget:self action:@selector(drawClearBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];


    self.drawSaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.drawBar addSubview:self.drawSaveBtn];
    [self.drawSaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.drawBar.mas_right).offset(-18);
        make.centerY.equalTo(self.drawBar);
        make.width.height.mas_equalTo(30);
    }];
    [self.drawSaveBtn setImage:[UIImage imageNamed:@"drawSave2"] forState:UIControlStateNormal];
    [self.drawSaveBtn addTarget:self action:@selector(drawSaveBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}



#pragma mark - LWDrawboardColorPickerViewDelegate

- (void)colorPickerView:(LWDrawboardColorPickerView *)colorPickerView pickedColor:(UIColor *)color{
    self.brushBackgroundView.backgroundColor = color;
    self.brushBackgroundView.image = nil;
}

- (void)pickerView:(LWDrawBoardPenPickerView *)pickerView pickedPenColor:(UIColor *)color{
    self.brushBoard.penColor = color;
}

- (void)pickerView:(LWDrawBoardPenPickerView *)pickerView pickedPenWidth:(CGFloat)penWidth{
    self.brushBoard.penWidth = penWidth;
}



#pragma mark - Color & Pen Picker

-(void)showDrawColorPicerView{
    if(!_drawColorSelector){
        _drawColorSelector = [LWDrawboardColorPickerView colorPickerWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40) delegate:self];
        [self.view addSubview:_drawColorSelector];

        [_drawColorSelector mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view.mas_leading).offset(0);
            make.trailing.equalTo(self.view.mas_trailing).offset(0);
            make.bottom.equalTo(self.drawBar.mas_top);
            make.height.mas_equalTo(40);
        }];

        UIColor *bgColor = self.brushBackgroundView.backgroundColor;
        CGFloat hue = 0, saturation = 0, brightness = 0,alpha = 0;
        [bgColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        if(alpha > 0.1){
            UIImage *colorImage = [UIImage circleWithColor:bgColor size:CGSizeMake(30, 30)];
            [_drawColorSelector.currentColorBtn setImage:colorImage forState:UIControlStateNormal];
        }else{
            [_drawColorSelector.currentColorBtn setImage:[UIImage imageNamed:@"whiteColor"] forState:UIControlStateNormal];
        }
        _drawColorSelector.selectedColor = self.brushBackgroundView.backgroundColor;
    }
}

-(void)hideDrawColorPickerView{
    if(_drawColorSelector){
        [_drawColorSelector removeFromSuperview];
        _drawColorSelector = nil;
    }
}

-(void)showDrawPenPickerView{
    if(!_drawPenSelector){
        _drawPenSelector = [LWDrawBoardPenPickerView penPickerWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40) delegate:self];
        [self.view addSubview:_drawPenSelector];

        [_drawPenSelector mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view.mas_leading).offset(0);
            make.trailing.equalTo(self.view.mas_trailing).offset(0);
            make.bottom.equalTo(self.drawBar.mas_top);
            make.height.mas_equalTo(40);
        }];

        UIImage *colorImage = [UIImage circleWithColor:self.brushBoard.penColor size:CGSizeMake(30, 30)];
        [_drawPenSelector.currentColorBtn setImage:colorImage forState:UIControlStateNormal];
        _drawPenSelector.selectedColor = self.brushBoard.penColor;
    }
}

-(void)hideDrawPenPickerView{
    if(_drawPenSelector){
        [_drawPenSelector removeFromSuperview];
        _drawPenSelector = nil;
    }
}



#pragma mark - Action

-(void)colorWheelBtnTouchUpInside:(UIButton *)btn{
    btn.selected = !btn.selected;
    if(btn.selected){
        btn.backgroundColor = [UIColor grayColor];
        [self showDrawColorPicerView];
    }else{
        btn.backgroundColor = [UIColor clearColor];
        [self hideDrawColorPickerView];
    }

    self.colorPenBtn.backgroundColor = [UIColor clearColor];
    self.colorPenBtn.selected = NO;
    [self hideDrawPenPickerView];
}

-(void)colorPenBtnTouchUpInside:(UIButton *)btn{
    btn.selected = !btn.selected;
    if(btn.selected){
        btn.backgroundColor = [UIColor grayColor];
        [self showDrawPenPickerView];
    }else{
        btn.backgroundColor = [UIColor clearColor];
        [self hideDrawPenPickerView];
    }

    self.colorWheelBtn.backgroundColor = [UIColor clearColor];
    self.colorWheelBtn.selected = NO;
    [self hideDrawColorPickerView];
}

-(void)drawClearBtnTouchUpInside:(UIButton *)btn{
    btn.backgroundColor = [UIColor clearColor];
    [self.brushBoard cleanDrawImage];

    self.colorWheelBtn.backgroundColor = [UIColor clearColor];
    self.colorWheelBtn.selected = NO;
    [self hideDrawColorPickerView];

    self.colorPenBtn.backgroundColor = [UIColor clearColor];
    self.colorPenBtn.selected = NO;
    [self hideDrawPenPickerView];
}

-(void)drawSaveBtnTouchUpInside:(UIButton *)btn{
    btn.backgroundColor = [UIColor clearColor];
    self.colorWheelBtn.backgroundColor = [UIColor clearColor];
    self.colorWheelBtn.selected = NO;
    [self hideDrawColorPickerView];

    self.colorPenBtn.backgroundColor = [UIColor clearColor];
    self.colorPenBtn.selected = NO;
    [self hideDrawPenPickerView];

    UIImage *image = [self.drawBoard snapshotImage];

    //保存照片
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(photoSaved:didFinishSavingWithError:contextInfo:), nil);
    NSData *data = UIImagePNGRepresentation(image);
    [[ALAssetsLibrary new] writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        if(!error){
            [self showHudWithText:NSLocalizedString(@"Save Success", nil) mode:MBProgressHUDModeText afterDelay:0.5];
        }else{
            [self showHudWithText:NSLocalizedString(@"Save Faild", nil) mode:MBProgressHUDModeText afterDelay:0.5];
        }
    }];

}

//显示已保存完成后的操作提示
-(void)photoSaved:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if(!error){
        [self showHudWithText:NSLocalizedString(@"Save Success", nil) mode:MBProgressHUDModeText afterDelay:0.5];
    } else{
        [self showHudWithText:NSLocalizedString(@"Save Faild", nil) mode:MBProgressHUDModeText afterDelay:0.5];
    }
}

- (void)showHudWithText:(NSString *)text mode:(MBProgressHUDMode)mode afterDelay:(NSTimeInterval)delay {
    if (!self.hud) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.label.text = text;
        self.hud.mode = mode;
        [self.hud hideAnimated:YES afterDelay:delay];
    }
}



@end
