//
//  LWDrawWrapView.m
//  LWInputMethod
//
//  Created by luowei on 16/6/26.
//  Copyright (c) 2016 MerryUnion. All rights reserved.
//

#import <Photos/Photos.h>
#import "LWDrawWrapView.h"
#import "LWDrawView.h"
#import "LWDrawBar.h"
#import "View+MASAdditions.h"
#import "LWDrawExtentions.h"


@implementation LWDrawWrapView

+ (LWDrawWrapView *)drawWrapViewWithDelegate:(id<LWDrawWrapViewProtocol>) delegate {
    LWDrawWrapView *wrapView = [LWDrawWrapView new];
    wrapView.delegate = delegate;
    return wrapView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];

        //绘制视图
        self.drawView = [LWDrawView drawViewWithDelegate:self];
        [self addSubview:self.drawView];
        [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(-50);
        }];
        [self.drawView setEnableEdit:NO];
        self.drawView.delegate = self;

        //编辑
        self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.editBtn];
        [self.editBtn setImage:UIImageWithName(@"EditBtn",self) forState:UIControlStateNormal];
        [self.editBtn setImage:UIImageWithName(@"NoEditBtn",self) forState:UIControlStateSelected];
        self.editBtn.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        self.editBtn.layer.cornerRadius = 4;
        [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(30);
            make.right.equalTo(self).offset(-6);
            make.width.height.mas_equalTo(30);
        }];
        [self.editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        self.editBtn.selected = YES;   //edit禁用,selected 为 Yes

        //工具条
        self.drawBar = [LWDrawBar drawBarWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40)];
        [self addSubview:self.drawBar];
        [self.drawBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(40);
        }];
//        self.drawBar.hidden = YES;  //设置初始约束，隐藏DrawBar工具条

        //颜色指示
        self.colorTipView = [UIView new];
        [self addSubview:self.colorTipView];
        [self.colorTipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.drawView.mas_bottom);
            make.bottom.equalTo(self.drawBar.mas_top);
        }];


    }

    return self;
}


#pragma mark - Action


-(void)resetDrawing {
    [self.drawView resetDrawing];
}


- (void)editBtnAction:(UIButton *)editBtn {

    if (!self.drawView.enableEdit) {
        self.drawView.enableEdit = YES;
        editBtn.selected = NO;
    } else {
        self.drawView.enableEdit = NO;
        editBtn.selected = YES; //edit禁用,selected 为 Yes
    }
}



- (NSArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending{
    if([self.delegate respondsToSelector:@selector(getAllAssetInPhotoAblumWithAscending:)]){
        return [self.delegate getAllAssetInPhotoAblumWithAscending:NO];
    }
    return nil;
}

#pragma mark - LWDrawViewProtocol

- (void)requestTileImageForAsset:(PHAsset *)tileAsset size:(CGSize)size
      completion:(void (^)(UIImage *, NSDictionary *))completion {

    if([self.delegate respondsToSelector:@selector(requestImageForAsset:size:completion:)]){
        [self.delegate requestImageForAsset:tileAsset size:size completion:completion];
    }
}


@end
