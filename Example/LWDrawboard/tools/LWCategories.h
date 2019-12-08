//
// Created by luowei on 2019/5/9.
// Copyright (c) 2019 luowei. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIButton (Extension)

@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@end


@interface NSObject (LWDevice)

//振动
-(void)vibrate;

-(BOOL)is_iPad;

@end