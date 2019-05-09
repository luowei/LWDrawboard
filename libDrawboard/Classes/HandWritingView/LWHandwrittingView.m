//
// Created by Luo Wei on 2017/3/25.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import "LWHandwrittingView.h"


@interface LWHandwrittingView ()
@end

@implementation LWHandwrittingView {
    NSMutableArray *_points;
    NSMutableString *_inputcharaters;
}

+(instancetype)handwrittingViewWithFrame:(CGRect)frame delegate:(id<LWHandwrittingViewProtocol>)delegate {
    LWHandwrittingView *handwrittingView = [[LWHandwrittingView alloc] initWithFrame:frame];
    handwrittingView.delegate = delegate;
    return handwrittingView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        _points = @[].mutableCopy;
        _inputcharaters = [@"" mutableCopy];
        _pathes = @[].mutableCopy;
        _lineWidth = 6;
        _lineColor = [UIColor darkTextColor];
    }

    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for(NSArray *points in self.pathes) {
        if(points.count <= 0){
            return;
        }
        [self drawCurveWithPoints:points];
    }

    //加上则有，跟随绘制效果
    if(_points.count > 0){
        [self drawCurveWithPoints:_points];
    }

}

//根据点集绘制一条曲线
- (void)drawCurveWithPoints:(NSArray *)points {
    UIColor *color = self.lineColor;   //曲线颜色

    UIBezierPath *pointsPath = [UIBezierPath bezierPath];
    CGPoint pt = [points[0] CGPointValue];
    [pointsPath moveToPoint:pt];
    CGPoint lastPt = pt;

    for (int i = 1; i < points.count; i++) {
        //画一条曲线到第i个点
        pt = [points[i] CGPointValue];
        [pointsPath addQuadCurveToPoint:CGPointMake((pt.x + lastPt.x) / 2, (pt.y + lastPt.y) / 2) controlPoint:lastPt];
        lastPt = pt;
    }
    [pointsPath addLineToPoint:pt];
    pointsPath.lineCapStyle = kCGLineCapRound;
    pointsPath.lineJoinStyle = kCGLineJoinRound;

    [color setStroke];
    pointsPath.lineWidth = self.lineWidth; //设置线宽
    [pointsPath stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//    Log(@"--------%d:%s \n\n", __LINE__, __func__);

    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];

    [_points addObject:[NSValue valueWithCGPoint:touchLocation]];
    [_inputcharaters appendFormat:@"%da%da", (int)rint(touchLocation.x),(int)rint(touchLocation.y)];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
//    Log(@"--------%d:%s \n\n", __LINE__, __func__);

    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];

    [_points addObject:[NSValue valueWithCGPoint:touchLocation]];

    if([self.delegate respondsToSelector:@selector(touchMovedWithPoint:pathPoints:)]){
        [self.delegate touchMovedWithPoint:touchLocation pathPoints:_points];
    }

    [self setNeedsDisplay]; //绘制刷新
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
//    Log(@"--------%d:%s \n\n", __LINE__, __func__);

    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];

    [_points addObject:[NSValue valueWithCGPoint:touchLocation]];

    [self.pathes addObject:[NSArray arrayWithArray:_points] ];    //把点集加入到路径里

    if([self.delegate respondsToSelector:@selector(touchMoveEndWithPoint:pathPoints:)]){
        [self.delegate touchMoveEndWithPoint:touchLocation pathPoints:_points];
    }
    
    [_points removeAllObjects];     //删除点集中所有点，准备下一次绘制

    [self setNeedsDisplay]; //绘制刷新


}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
//    NSLog(@"--------%d:%s \n\n", __LINE__, __func__);

    [self.pathes addObject:[NSArray arrayWithArray:_points]];    //把点集加入到路径里

    if([self.delegate respondsToSelector:@selector(touchCancelledWithPathPoints:)]){
        [self.delegate touchCancelledWithPathPoints:_points];
    }
    
    [_points removeAllObjects]; //删除点集中所有点，准备下一次绘制

    [self setNeedsDisplay]; //绘制刷新

}

@end
