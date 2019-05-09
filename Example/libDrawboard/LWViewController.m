//
//  LWViewController.m
//  libDrawboard
//
//  Created by luowei on 05/08/2019.
//  Copyright (c) 2019 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWViewController.h"
#import "LWPhotoPicker.h"
#import "LWDrawWrapView.h"
#import "LWBrushBoardViewController.h"
#import "LWHandwrittingViewController.h"
#import <libDrawboard/LWDrawWrapView.h>
#import <Masonry/Masonry-umbrella.h>

@interface LWViewController () <LWDrawWrapViewProtocol>

@property(nonatomic, strong) LWPhotoPicker *photoPicker;
@property(nonatomic, strong) UIButton *resetBtn;
@property(nonatomic, strong) LWDrawWrapView *drawWrapView;
@end

@implementation LWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.photoPicker = [LWPhotoPicker new];

    self.drawWrapView = [LWDrawWrapView drawWrapViewWithDelegate:self];
    [self.view addSubview:self.drawWrapView];
    [self.drawWrapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.resetBtn];
    [self.resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view).offset(-60);
    }];
    [self.resetBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.resetBtn addTarget:self action:@selector(resetBtnAction) forControlEvents:UIControlEventTouchUpInside];


}

- (void)resetBtnAction {
    [self.drawWrapView resetDrawing];
}

//简单画板
- (IBAction)simpleDrawboardAction:(id)sender {
    [self.navigationController pushViewController:[LWHandwrittingViewController new] animated:YES];
}

//软笔画板
- (IBAction)penDrawboardAction:(id)sender {
    [self.navigationController pushViewController:[LWBrushBoardViewController new] animated:YES];
}

#pragma mark - LWDrawWrapViewProtocol

- (NSArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending{
    return [self.photoPicker getAllAssetInPhotoAblumWithAscending:NO];
}

- (void)requestImageForAsset:(PHAsset *)tileAsset size:(CGSize)size completion:(void (^)(UIImage *, NSDictionary *))completion {

    [self.photoPicker requestImageForAsset:tileAsset
                                      size:size
                               synchronous:YES
                                completion:^(UIImage *image, NSDictionary *info) {
                                    if (completion) {
                                        completion(image, info);
                                    }
                                }];
}

@end
