//
// Created by luowei on 2019/5/9.
// Copyright (c) 2019 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <libDrawboard/LWHandwrittingView.h>

@class LWHandWrittingWrapView;


@interface LWHandwrittingViewController : UIViewController<LWHandwrittingViewProtocol>

@property(nonatomic, strong) LWHandWrittingWrapView *hwWrapView;

@property(nonatomic, strong) LWHandwrittingView *hwView;
@end


@interface LWHandWrittingWrapView:UIView
@end