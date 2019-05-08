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
#import <libDrawboard/LWDrawWrapView.h>
#import <Masonry/Masonry-umbrella.h>

@interface LWViewController () <LWDrawWrapViewProtocol>

@property(nonatomic, strong) LWPhotoPicker *photoPicker;
@end

@implementation LWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    LWDrawWrapView *drawWrapView = [LWDrawWrapView drawWrapViewWithDelegate:self];
    [self.view addSubview:drawWrapView];
    [drawWrapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

}

#pragma mark - LWDrawWrapViewProtocol

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
