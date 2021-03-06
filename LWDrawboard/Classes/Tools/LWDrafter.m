//
// Created by luowei on 16/10/8.
// Copyright (c) 2016 wodedata. All rights reserved.
//

#import "LWDrafter.h"
#import "LWDrawExtentions.h"


@implementation LWDrafter {

}

- (instancetype)init {
    self = [super init];
    if (self) {
        _pointArr = [NSMutableArray array];
        _isNew = YES;
        _color = [UIColor blackColor];
        _rect = CGRectZero;

        _pathBounds = CGRectZero;
        _rotateAngle = 0;
        _scaleRect = CGRectZero;
        _movePoint = CGPointZero;

        _openShadow = NO;
    }
    return self;
}

- (NSShadow *)shadow {
    if (!_shadow) {
        UIColor *shadowColor = self.color.isLight ? [UIColor.blackColor colorWithAlphaComponent:0.6] : [UIColor.whiteColor colorWithAlphaComponent:0.6];
        _shadow = [[NSShadow alloc] init];
        [_shadow setShadowColor:shadowColor];
        [_shadow setShadowOffset:CGSizeMake(1.1, 1.1)];
        [_shadow setShadowBlurRadius:2];
    }
    return _shadow;
}


- (UIColor *)color {
    return _color ?: [UIColor blackColor];

}

- (CGSize)burshSize {
    return CGSizeMake(_lineWidth * 4, _lineWidth * 4);
}


@end
