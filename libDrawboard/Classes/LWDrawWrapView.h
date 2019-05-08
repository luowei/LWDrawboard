//
//  LWDrawWrapView.h
//  LWInputMethod
//
//  Created by luowei on 16/6/26.
//  Copyright (c) 2016 MerryUnion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWDrawView.h"

@class LWDrawView;
@class LWDrawBar;
@class LWTileImagesView;
@class LWColorSelectorView;
@class LWFontSelectorView;
@class PHAsset;

@interface LWDrawWrapView : UIView<LWDrawViewProtocol>

@property(strong, nonatomic) LWDrawView *drawView;
@property(strong, nonatomic) LWDrawBar *drawBar;
@property(strong, nonatomic) UIView *colorTipView;

@property(nonatomic,strong) UIButton *editBtn;


+ (LWDrawWrapView *)drawWrapView;

- (void)editBtnAction:(UIButton *)editBtn;
- (void)showDrawToolAction:(UIButton *)sender;



- (NSArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending;

- (void)requestTileImageForAsset:(PHAsset *)tileAsset size:(CGSize)size
                      completion:(void (^)(UIImage *, NSDictionary *))completion;

@end
