//
// Created by luowei on 2019/5/9.
// Copyright (c) 2019 luowei. All rights reserved.
//

#import <libDrawboard/LWHandwrittingView.h>
#import <libDrawboard/LWDrawExtentions.h>
#import <Masonry/Masonry.h>
#import "LWHandwrittingViewController.h"
#import "LWDrawExtentions.h"


@implementation LWHandwrittingViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.hwWrapView = [LWHandWrittingWrapView new];
    [self.view addSubview:self.hwWrapView];
    [self.hwWrapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.hwView = [LWHandwrittingView handwrittingViewWithFrame:self.view.bounds delegate:self];
    [self.hwWrapView addSubview:self.hwView];
    [self.hwView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

}


#pragma mark - LWHandwrittingViewProtocol

- (void)touchMovedWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints {

}

- (void)touchMoveEndWithPoint:(CGPoint)touchPoint pathPoints:(NSMutableArray *)pathPoints {

}

- (void)touchCancelledWithPathPoints:(NSMutableArray *)pathPoints {

}


@end



@implementation LWHandWrittingWrapView

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    LWHandwrittingViewController *vc = [self draw_superViewWithClass:[LWHandwrittingViewController class]];
//    [vc.hwView touchesBegan:touches withEvent:event];
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    LWHandwrittingViewController *vc = [self draw_superViewWithClass:[LWHandwrittingViewController class]];
//    [vc.hwView touchesMoved:touches withEvent:event];
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    LWHandwrittingViewController *vc = [self draw_superViewWithClass:[LWHandwrittingViewController class]];
//    [vc.hwView touchesEnded:touches withEvent:event];
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    LWHandwrittingViewController *vc = [self draw_superViewWithClass:[LWHandwrittingViewController class]];
//    [vc.hwView touchesCancelled:touches withEvent:event];
//}


@end