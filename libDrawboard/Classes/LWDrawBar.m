//
// Created by luowei on 16/10/11.
// Copyright (c) 2016 wodedata. All rights reserved.
//

#import <Photos/Photos.h>
#import "LWDrawBar.h"
#import "LWDrawView.h"
#import "View+MASAdditions.h"
#import "LWDrawExtentions.h"
#import "LWDrawWrapView.h"

#define NarrowLine_W 0.5

#pragma mark - LWDrawBar

@implementation LWDrawBar {
    CALayer *_topLine;
}


+ (LWDrawBar *)drawBarWithFrame:(CGRect)frame{
    LWDrawBar *drawBar = [[LWDrawBar alloc] initWithFrame:frame];
    return drawBar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        //drawToolsView
        self.drawToolsView = [LWDrawToolsView toolView];
        [self addSubview:self.drawToolsView];
        [self.drawToolsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];

        //topLine
        _topLine = [CALayer layer];
        [self.layer addSublayer:_topLine];
        _topLine.frame = CGRectMake(0, 0, self.frame.size.width, NarrowLine_W);
        _topLine.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7].CGColor;
    }

    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _topLine.frame = CGRectMake(0, 0, self.frame.size.width, NarrowLine_W);
}



@end






#pragma mark - LWDrawToolsView （工具条）

//画板工具的选择
@implementation LWDrawToolsView {
    NSIndexPath *_sec1SelectedIndexPath;
    NSIndexPath *_sec2SelectedIndexPath;
    NSIndexPath *_sec3SelectedIndexPath;
}

+ (LWDrawToolsView *)toolView{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(40, 40);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    LWDrawToolsView *toolsView = [[LWDrawToolsView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds ), 40) collectionViewLayout:layout];
    return toolsView;
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        self.delegate = self;
        self.dataSource = self;

        [self registerClass:[LWToolsCell class] forCellWithReuseIdentifier:@"ToolCell"];
        [self registerClass:[LWToolsSliderCell class] forCellWithReuseIdentifier:@"ToolSliderCell"];
    }

    return self;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 6;
        case 1:
            return 2;
        case 2:
            return 3;
        case 3:
            return 11;
        default:
            return 1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LWToolsCell *cell = (LWToolsCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"ToolCell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.item) {
                case 0: {    //黑笔
                    [cell.btn setImage:UIImageWithName(@"pen", self) forState:UIControlStateNormal];
                    [self sec1SelectStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 1: {    //纹底笔
                    [cell.btn setImage:UIImageWithName(@"penTile", self) forState:UIControlStateNormal];
                    [self sec1SelectStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 2:{    //毛笔
                    [cell.btn setImage:UIImageWithName(@"chinesePen", self) forState:UIControlStateNormal];
                    [self sec1SelectStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 3: {    //打开阴影
                    [cell.btn setImage:UIImageWithName(@"shade", self) forState:UIControlStateNormal];
                    //[self sec1Collection:collectionView selIndexPath:indexPath cell:cell];
                    [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
                    LWDrawWrapView *drawWrapView = [self draw_superViewWithClass:[LWDrawWrapView class]];
                    cell.highlighted = drawWrapView.drawView.openShadow;
                    break;
                }
                case 4: {    //颜色
                    [cell.btn setImage:UIImageWithName(@"colorInkWheel", self) forState:UIControlStateNormal];
                    [self sec1SelectStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 5: {    //橡皮
                    [cell.btn setImage:UIImageWithName(@"eraser", self) forState:UIControlStateNormal];
                    [self sec1SelectStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                default:
                    break;
            }
            break;
        case 1:{
            switch (indexPath.item) {
                case 0: {
                    [cell.btn setImage:UIImageWithName(@"revoke", self) forState:UIControlStateNormal];
                    break;
                }
                case 1:{
                    LWToolsSliderCell *sliderCell = (LWToolsSliderCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"ToolSliderCell" forIndexPath:indexPath];
                    return sliderCell;
                }
                default:
                    break;
            }
            break;
        }
        case 2:
            switch (indexPath.item) {
                case 0: {    //小画笔
                    [cell.btn setImage:UIImageWithName(@"dotSmall", self) forState:UIControlStateNormal];
                    [self sec3SelectStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 1: {    //中画笔
                    [cell.btn setImage:UIImageWithName(@"dotMiddle", self) forState:UIControlStateNormal];
                    [self sec3SelectStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 2: {    //大画笔
                    [cell.btn setImage:UIImageWithName(@"dotLarge", self) forState:UIControlStateNormal];
                    [self sec3SelectStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                default:
                    break;
            }
            break;
        case 3:
            switch (indexPath.item) {
                case 0: {   //直线
                    [cell.btn setImage:UIImageWithName(@"line", self) forState:UIControlStateNormal];
                    [self sec4SelctStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 1: {   //虚线
                    [cell.btn setImage:UIImageWithName(@"lineDash", self) forState:UIControlStateNormal];
                    [self sec4SelctStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 2: {   //箭头
                    [cell.btn setImage:UIImageWithName(@"lineArrow", self) forState:UIControlStateNormal];
                    [self sec4SelctStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 3: {   //矩形
                    [cell.btn setImage:UIImageWithName(@"rect", self) forState:UIControlStateNormal];
                    [self sec4SelctStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 4: {   //矩形(虚线)
                    [cell.btn setImage:UIImageWithName(@"rectDash", self) forState:UIControlStateNormal];
                    [self sec4SelctStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 5: {   //矩形(填充)
                    [cell.btn setImage:UIImageWithName(@"rectFill", self) forState:UIControlStateNormal];
                    [self sec4SelctStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 6: {   //圆圈
                    [cell.btn setImage:UIImageWithName(@"oval", self) forState:UIControlStateNormal];
                    [self sec4SelctStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 7: {   //圆圈(虚线)
                    [cell.btn setImage:UIImageWithName(@"ovalDash", self) forState:UIControlStateNormal];
                    [self sec4SelctStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 8: {   //圆圈(填充)
                    [cell.btn setImage:UIImageWithName(@"ovalFill", self) forState:UIControlStateNormal];
                    [self sec4SelctStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 9: {   //虚曲线
                    [cell.btn setImage:UIImageWithName(@"curveDash", self) forState:UIControlStateNormal];
                    [self sec4SelctStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }
                case 10: {   //文字
                    [cell.btn setImage:UIImageWithName(@"text", self) forState:UIControlStateNormal];
                    [self sec4SelctStatusForCollection:collectionView indexPath:indexPath cell:cell];
                    break;
                }

                default:
                    break;
            }
            break;

        default:
            break;
    }

    return cell;
}

- (void)sec1SelectStatusForCollection:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath cell:(LWToolsCell *)cell {
    if ((_sec1SelectedIndexPath != nil && _sec1SelectedIndexPath.item == indexPath.item) || (_sec1SelectedIndexPath == nil && indexPath.item == 0)) {
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        cell.highlighted = YES;
    } else {
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
        cell.highlighted = NO;
    }
}
- (void)sec3SelectStatusForCollection:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath cell:(LWToolsCell *)cell {
    if ((_sec2SelectedIndexPath != nil && _sec2SelectedIndexPath.item == indexPath.item) || (_sec2SelectedIndexPath == nil && indexPath.item == 0)) {
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        cell.highlighted = YES;
    } else {
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
        cell.highlighted = NO;
    }
}
- (void)sec4SelctStatusForCollection:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath cell:(LWToolsCell *)cell {
    if (_sec3SelectedIndexPath != nil && _sec3SelectedIndexPath.item == indexPath.item) {
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        cell.highlighted = YES;
    } else {
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
        cell.highlighted = NO;
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.item == 1){
        return CGSizeMake(200, 40);
    }else{
        return CGSizeMake(40, 40);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LWToolsCell *cell = (LWToolsCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"ToolCell" forIndexPath:indexPath];

    LWDrawWrapView *drawWrapView = [self draw_superViewWithClass:[LWDrawWrapView class]];
    LWDrawView *drawView = drawWrapView.drawView;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.item) {
                case 0: {    //黑笔
                    drawView.drawType = Hand;
                    drawView.freeInkColor = [UIColor blackColor];
                    drawWrapView.colorTipView.backgroundColor = [UIColor colorWithHexString:DrawView_Color_Items[0]];
                    [self sec1collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 1: {    //纹底笔
                    drawView.drawType = EmojiTile;
                    [LWTileImagesView showTileImagesView:drawWrapView];
                    [self sec1collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 2:{    //毛笔
                    drawView.drawType = ChinesePen;
                    [self sec1collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 3: {    //阴影
                    drawView.openShadow = !drawView.openShadow;
//                    [self sec1collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
                    cell.highlighted = drawView.openShadow;
                    [collectionView reloadSections:[NSIndexSet indexSetWithIndex:(NSUInteger) indexPath.section]];
                    break;
                }
                case 4: {    //颜色
//                    if(drawView.drawType != Text){
//                        drawView.drawType = Hand;
//                    }
//                    [self sec1collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    [LWColorSelectorView showColorSelectorViewInView:drawWrapView];
                    break;
                }
                case 5: {    //橡皮
                    drawView.drawType = Erase;
                    [self sec1collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                default:
                    break;
            }
            break;
        case 1:{
            switch (indexPath.item) {
                case 0: {
                    [drawView.curves removeLastObject];
                    [drawView setNeedsDisplay];
                    break;
                }
                case 1:{

                }
                default:
                    break;
            }
            break;
        }
        case 2:
            switch (indexPath.item) {
                case 0: {    //小画笔
                    drawView.freeInkLinewidth = 3.0;
                    [self sec3collectionView:collectionView selecteIndexPath:indexPath cell:cell];
                    LWToolsSliderCell *toolSliderCell = (LWToolsSliderCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:1]];
                    toolSliderCell.slider.value = (float) (3.0 / 60);
                    break;
                }
                case 1: {    //中画笔
                    drawView.freeInkLinewidth = 6.0;
                    [self sec3collectionView:collectionView selecteIndexPath:indexPath cell:cell];
                    LWToolsSliderCell *toolSliderCell = (LWToolsSliderCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:1]];
                    toolSliderCell.slider.value = (float) (6.0 / 60);
                    break;
                }
                case 2: {    //大画笔
                    drawView.freeInkLinewidth = 12.0;
                    [self sec3collectionView:collectionView selecteIndexPath:indexPath cell:cell];
                    LWToolsSliderCell *toolSliderCell = (LWToolsSliderCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:1]];
                    toolSliderCell.slider.value = (float) (12.0 / 60);
                    break;
                }
                default:
                    break;
            }
            break;
        case 3:
            switch (indexPath.item) {
                case 0: {   //直线
                    drawView.drawType = Line;
                    [self sec4collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 1: {   //虚线
                    drawView.drawType = LineDash;
                    [self sec4collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 2: {   //箭头
                    drawView.drawType = LineArrow;
                    [self sec4collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 3: {   //矩形
                    drawView.drawType = Rectangle;
                    [self sec4collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 4: {   //矩形(虚线)
                    drawView.drawType = RectangleDash;
                    [self sec4collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 5: {   //矩形(填充)
                    drawView.drawType = RectangleFill;
                    [self sec4collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 6: {   //圆圈
                    drawView.drawType = Oval;
                    [self sec4collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 7: {   //圆圈(虚线)
                    drawView.drawType = OvalDash;
                    [self sec4collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 8: {   //圆圈(填充)
                    drawView.drawType = OvalFill;
                    [self sec4collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 9: {   //虚曲线
                    drawView.drawType = CurveDash;
                    [self sec4collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                case 10: {   //文字
                    drawView.drawType = Text;
                    [LWFontSelectorView showFontSelectorView:drawWrapView];
                    [self sec4collectionView:collectionView selectIndexPath:indexPath cell:cell];
                    break;
                }
                default:
                    break;
            }
            break;

        default:
            break;
    }
    [drawView exitEditingOrTexting];

}

- (void)sec4collectionView:(UICollectionView *)collectionView selectIndexPath:(NSIndexPath *)indexPath cell:(LWToolsCell *)cell {
    [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    cell.highlighted = YES;
    _sec3SelectedIndexPath = indexPath;
    [collectionView reloadSections:[NSIndexSet indexSetWithIndex:(NSUInteger) indexPath.section]];
}
- (void)sec3collectionView:(UICollectionView *)collectionView selecteIndexPath:(NSIndexPath *)indexPath cell:(LWToolsCell *)cell {
    [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    cell.highlighted = YES;
    _sec2SelectedIndexPath = indexPath;
    [collectionView reloadSections:[NSIndexSet indexSetWithIndex:(NSUInteger) indexPath.section]];
}
- (void)sec1collectionView:(UICollectionView *)collectionView selectIndexPath:(NSIndexPath *)indexPath cell:(LWToolsCell *)cell {
    [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    cell.highlighted = YES;
    _sec1SelectedIndexPath = indexPath;
    [collectionView reloadSections:[NSIndexSet indexSetWithIndex:(NSUInteger) indexPath.section]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    LWToolsCell *cell = (LWToolsCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"ToolCell" forIndexPath:indexPath];
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    cell.highlighted = NO;
}


@end




#pragma mark - LWToolsCell（工具条的Cell）

@implementation LWToolsCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.btn];

        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];

        [self.btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }

    return self;
}

- (void)btnTouchUpInside:(UIButton *)btn {

    btn.backgroundColor = [UIColor clearColor];
    LWDrawToolsView *toolsView = [self draw_superViewWithClass:[LWDrawToolsView class]];
    NSIndexPath *indPath = [toolsView indexPathForCell:self];
    [toolsView.delegate collectionView:toolsView didSelectItemAtIndexPath:indPath];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if(highlighted){
        self.backgroundColor = [UIColor lightGrayColor];
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }

}

@end

@implementation LWToolsSliderCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.slider = [[UISlider alloc] init];
        [self addSubview:self.slider];

        UIImage *thumbImage = UIImageWithName(@"thumb_circle",self);
        [self.slider setThumbImage:thumbImage forState:UIControlStateNormal];

        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(5);
            make.right.equalTo(self.mas_right).offset(-5);
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];

        self.slider.value = (float) (3.0/60);
        [self.slider addTarget:self action:@selector(slideMove:) forControlEvents:UIControlEventValueChanged];
    }

    return self;
}

-(void)slideMove:(UISlider *)slider{
    LWDrawWrapView *drawWrapView = [self draw_superViewWithClass:[LWDrawWrapView class]];
    drawWrapView.drawView.freeInkLinewidth = 60 * slider.value;
}


@end







#pragma mark - LWColorSelectorView （颜色选择面板）

//画笔颜色选择
@implementation LWColorSelectorView {
}

+(LWColorSelectorView *)showColorSelectorViewInView:(UIView *)view{

    LWColorSelectorView *colorSelectorView = nil;
    for(LWColorSelectorView *v in view.subviews){
        if([v isKindOfClass:[LWColorSelectorView class]]){
            colorSelectorView = v;
            break;
        }
    }

    if(!colorSelectorView){
        CGRect vBounds = view.bounds;
        colorSelectorView = [[LWColorSelectorView alloc] initWithFrame:CGRectMake(0, vBounds.size.height - 40, vBounds.size.width, 40)];
        [view addSubview:colorSelectorView];

        colorSelectorView.frame = CGRectMake(0, vBounds.size.height - 40, vBounds.size.width, 40);
    }

    return colorSelectorView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(40, 40);

    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        self.scrollEnabled = YES;
        self.bounces = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollsToTop = NO;

        [self registerClass:[LWColorCell class] forCellWithReuseIdentifier:@"ColorCell"];

        self.delegate = self;
        self.dataSource = self;

    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect vBounds = self.superview.bounds;
    self.frame = CGRectMake(0, vBounds.size.height - 40, vBounds.size.width, 40);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return DrawView_Color_Items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LWColorCell *cell = (LWColorCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"ColorCell" forIndexPath:indexPath];
    NSString *hexString = DrawView_Color_Items[(NSUInteger) indexPath.item];
    cell.colorView.backgroundColor = [UIColor colorWithHexString:hexString];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LWColorCell *cell = (LWColorCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"ColorCell" forIndexPath:indexPath];

    LWDrawWrapView *drawWrapView = [self draw_superViewWithClass:[LWDrawWrapView class]];
    LWDrawView *drawView = drawWrapView.drawView;
    UIColor *color = [UIColor colorWithHexString:DrawView_Color_Items[(NSUInteger) indexPath.item]];
    drawView.freeInkColor = color;
    drawWrapView.colorTipView.backgroundColor = color;
    [self removeFromSuperview];
}

@end

#pragma mark - LWColorCell （颜色选择面板的Cell）

@implementation LWColorCell {
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.colorView.layer.borderWidth = NarrowLine_W;
        self.colorView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.colorView.frame = self.bounds;
}

-(UIView *)colorView{
    if(!_colorView || _colorView.superview == nil){
        _colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_colorView];
    }
    return _colorView;
}

@end





#pragma mark - LWTileImagesView (底纹图片选择面板)

@implementation LWTileImagesView{
}

+(LWTileImagesView *)showTileImagesView:(UIView *)view{

    LWTileImagesView *tileImagesView = nil;
    for(LWTileImagesView *v in view.subviews){
        if([v isKindOfClass:[LWTileImagesView class]]){
            tileImagesView = v;
            break;
        }
    }

    if(!tileImagesView){
        CGRect vBounds = view.bounds;
        tileImagesView = [[LWTileImagesView alloc] initWithFrame:CGRectMake(0, vBounds.size.height - 45, vBounds.size.width, 45)];
        [view addSubview:tileImagesView];

        tileImagesView.frame = CGRectMake(0, vBounds.size.height - 45, vBounds.size.width, 45);
    }

    return tileImagesView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(45, 45);
    layout.headerReferenceSize = CGSizeMake(45, 45);

    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        self.scrollEnabled = YES;
        self.bounces = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollsToTop = NO;

        self.dataSource = self;
        self.delegate = self;
        _currentDrawType = EmojiTile;
        _itemsData = Emoji_Items;

        [self registerClass:[LWTileHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TileHeader"];
        [self registerClass:[LWTileCell class] forCellWithReuseIdentifier:@"TileCell"];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = CGRectMake(0, self.superview.frame.size.height - 45, self.superview.frame.size.width, 45);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _itemsData.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LWTileCell *cell = (LWTileCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"TileCell" forIndexPath:indexPath];
    __block UIImage *tileImage = UIImageWithName(@"luowei", self);

    if(_currentDrawType == EmojiTile){
        tileImage = [((NSString *) _itemsData[(NSUInteger) indexPath.item]) image:CGSizeMake(45 * 2,45 * 2)];
    }else{
        PHAsset *asset = (PHAsset *) _itemsData[(NSUInteger) indexPath.item];

        DrawLog(@"=====asset localIdentifier:%@",asset.localIdentifier);
        __weak typeof(cell) weakCell = cell;

        LWDrawWrapView *drawWrapView = [self draw_superViewWithClass:[LWDrawWrapView class]];
        [drawWrapView requestTileImageForAsset:asset size:CGSizeMake(45 * 2, 45 * 2)
                                    completion:^(UIImage *image, NSDictionary *info) {
                                        dispatch_async(dispatch_get_main_queue(), ^() {
                                            tileImage = image;
                                            weakCell.imageView.image = tileImage;
                                        });
                                    }];
    }

    cell.imageView.image = tileImage;
    return cell;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        self.tileHeader = (LWTileHeader *) [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"TileHeader" forIndexPath:indexPath];
        return self.tileHeader;

    }
    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LWTileCell *cell = (LWTileCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"TileCell" forIndexPath:indexPath];

    LWDrawWrapView *drawWrapView = [self draw_superViewWithClass:[LWDrawWrapView class]];
    drawWrapView.drawView.drawType = _currentDrawType;
    
    switch (_currentDrawType) {
        case EmojiTile:{
            NSString *tileEmojiText = _itemsData[(NSUInteger) indexPath.item];
            drawWrapView.drawView.tileEmojiText = tileEmojiText ?: @"👀";
            break;
        }
        case ImageTile:{
            PHAsset *asset = (PHAsset *) _itemsData[(NSUInteger) indexPath.item];
            drawWrapView.drawView.tileAsset = asset;
            break;
        }
        default:
            break;
    }

    [self removeFromSuperview];
}

@end


@implementation LWTileCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.imageView];
        self.imageView.userInteractionEnabled = NO;

        self.imageView.layer.borderWidth = 1.0;
        self.imageView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}


@end

@implementation LWTileHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.tileBtn];
        [self.tileBtn setImage:UIImageWithName(@"TileBtn",self) forState:UIControlStateNormal];

        self.tileBtn.layer.borderWidth = 1.0;
        self.tileBtn.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;

        [self.tileBtn addTarget:self action:@selector(tileBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.tileBtn.frame = self.bounds;
}



- (void)tileBtnAction {
    LWDrawWrapView *drawWrapView = [self draw_superViewWithClass:[LWDrawWrapView class]];
    LWTileImagesView * tileImagesView = [self draw_superViewWithClass:[LWTileImagesView class]];
    if(tileImagesView.currentDrawType == EmojiTile){
        tileImagesView.currentDrawType = ImageTile;

        tileImagesView.itemsData = [drawWrapView getAllAssetInPhotoAblumWithAscending:NO];
        [tileImagesView reloadData];
        [self.tileBtn setImage:UIImageWithName(@"EmojiBtn",self) forState:UIControlStateNormal];

    }else{
        tileImagesView.itemsData = Emoji_Items;
        tileImagesView.currentDrawType = EmojiTile;
        [tileImagesView reloadData];
        [self.tileBtn setImage:UIImageWithName(@"TileBtn",self) forState:UIControlStateNormal];
    }
}

@end







#pragma mark - LWFontSelectorView

@implementation LWFontSelectorView{
}

+(LWFontSelectorView *)showFontSelectorView:(UIView *)view{

    LWFontSelectorView *fontSelectorView = nil;
    for(LWFontSelectorView *v in view.subviews){
        if([v isKindOfClass:[LWFontSelectorView class]]){
            fontSelectorView = v;
            break;
        }
    }

    if(!fontSelectorView){
        CGRect vBounds = view.bounds;
        fontSelectorView = [[LWFontSelectorView alloc] initWithFrame:CGRectMake(0, vBounds.size.height - 45, vBounds.size.width, 45)];
        [view addSubview:fontSelectorView];

        fontSelectorView.frame = CGRectMake(0, vBounds.size.height - 45, vBounds.size.width, 45);
    }

    return fontSelectorView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(90, 45);

    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        self.scrollEnabled = YES;
        self.bounces = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollsToTop = NO;

        self.dataSource = self;
        self.delegate = self;

        [self registerClass:[LWFontCell class] forCellWithReuseIdentifier:@"FontCell"];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = CGRectMake(0, self.superview.frame.size.height - 45, self.superview.frame.size.width, 45);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return Default_FontNames.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LWFontCell *cell = (LWFontCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"FontCell" forIndexPath:indexPath];
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cellImgSize = CGSizeMake(90 * scale, 45 * scale);
    NSString *fontName = Default_FontNames[(NSUInteger) indexPath.item];

    //从缓存目录找,没有才去生成
    UIImage *image = UIImageWithName(@"luowei", self);
    image = [self getFontImageWithSize:cellImgSize fontName:fontName withIndexPath:indexPath];
    cell.imageView.image = image;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LWFontCell *cell = (LWFontCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"FontCell" forIndexPath:indexPath];

    NSString *fontName = Default_FontNames[(NSUInteger) indexPath.item];

    LWDrawWrapView *drawWrapView = [self draw_superViewWithClass:[LWDrawWrapView class]];
    drawWrapView.drawView.fontName = fontName;
    [self removeFromSuperview];
}


//根据字体获得指定大小的图片
- (UIImage *)getFontImageWithSize:(CGSize)cellImgSize fontName:(NSString *)fontName withIndexPath:(NSIndexPath *)indexPath {
//根据fontText,font以及cellImgSize,确定合适的fontSize,得到合适的文本矩形区attrTextRect
    NSString *fontText = @"你好Abc";
    CGFloat fontSize = 48;
    NSDictionary *attributes = nil;
    NSAttributedString *attrText = nil;
    CGRect attrTextRect = CGRectMake(0, 0, cellImgSize.width, cellImgSize.height);
    do {
        fontSize -= 4;
        attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],NSForegroundColorAttributeName : [UIColor blackColor],NSBackgroundColorAttributeName : [UIColor clearColor]};
        attrText = [[NSAttributedString alloc] initWithString:fontText attributes:attributes];
        attrTextRect = [attrText boundingRectWithSize:CGSizeMake(attrText.size.width, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    } while (fontSize > 20 && (attrTextRect.size.width > cellImgSize.width || attrTextRect.size.height > cellImgSize.height));

    UIImage *textImg = [UIImage imageFromString:fontText attributes:attributes size:attrTextRect.size];
    UIImage *colorImage = [UIImage imageFromColor:[UIColor whiteColor] withRect:CGRectMake(0, 0, cellImgSize.width, cellImgSize.height)];

    //合并图片
    CGRect logoFrame = CGRectMake((colorImage.size.width - textImg.size.width) / 2, (colorImage.size.height - textImg.size.height) / 2, textImg.size.width, textImg.size.height);
    UIImage *combinedImg = [UIImage addImageToImage:colorImage withImage2:textImg andRect:logoFrame withImageSize:cellImgSize];
    return combinedImg;
}


@end


@implementation LWFontCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.imageView];

        self.imageView.layer.borderWidth = 1.0;
        self.imageView.layer.borderColor = [UIColor colorWithHexString:@"#A1A1A1"].CGColor;
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.imageView.frame = self.bounds;
}


@end


