//
// Created by luowei on 16/10/11.
// Copyright (c) 2016 wodedata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LWDrafter.h"

#define DrawView_Color_Items (@[@"#000000",@"#808080",@"#C0C0C0",@"#800000",@"#A52A2A",@"#FFA500",@"#008000",@"#808000",@"#FFFFFF",@"#FF0000",@"#00FFFF",@"#0000FF",@"#0000A0",@"#ADD8E6",@"#800080",@"#FFFF00",@"#00FF00",@"#FF00FF"])

#define Emoji_Items (@[ @"👀",@"❤", @"💛", @"💙", @"💜", @"💔", @"❣", @"💕", @"💞", @"💓", @"💗", @"💖", @"💘", @"💝", @"⌚", @"📱", @"📲", @"💻", @"📹", @"🎥", @"📽", @"🎞", @"📞", @"☎", @"🚕", @"🚙", @"🚌", @"🚎", @"🏎", @"🚄", @"✈", @"🏕", @"⛺", @"🏞", @"🏘", @"🏰", @"🏯", @"🏟", @"🗽", @"🏠", @"🏡", @"🏚", @"🏢", @"💒", @"🏛", @"⛪", @"🕌", @"🕍", @"🕋", @"⚽", @"🏀", @"🏈", @"⚾", @"🎾", @"🏐", @"🏉", @"🎱", @"⛳", @"🏌", @"🏓", @"🏸", @"🏒", @"🏑", @"🏏", @"🎿", @"🍏", @"🍎", @"🍐", @"🍊", @"🍋", @"🍌", @"🍉", @"🍇", @"🍓", @"🍈", @"🍒", @"🍑", @"🍍", @"🍅", @"🍆", @"🌶", @"🌽", @"🍠", @"🍺", @"🍻", @"🍷", @"🍸", @"🍹", @"🍾", @"🍶", @"🍵", @"☕", @"☕", @"🍦", @"🍰", @"🎂", @"🍮", @"🐶", @"🐱", @"🐭", @"🐹", @"🐰", @"🐻", @"🐼", @"🐨", @"🐯", @"🦁", @"🐮", @"🐷", @"🐽", @"🐸", @"🐙", @"🐵", @"🐒", @"🐔", @"🐧", @"🐺", @"🐗", @"🐴", @"🦄", @"🐝", @"🐛", @"🐌", @"🐞", @"🐜", @"🕷", @"🦂", @"🦀", @"🐍", @"🐢", @"🕊", @"🐕", @"🐩", @"🐈", @"🐇", @"🐿", @"🐾", @"🐉", @"🐲", @"🌵", @"🎄", @"🌲", @"🌳", @"🌴", @"🌱", @"🌿", @"🍀", @"🎍", @"🎋", @"🍃", @"🍂", @"🍁", @"🌾", @"🌺", @"🌻", @"🌹", @"🌷", @"🌼", @"🌸", @"💐", @"🍄", @"🌰", @"🎃", @"🐚", @"🐎",@"😀", @"😬", @"😁", @"😂", @"😃", @"😄", @"😅", @"😆", @"😇", @"😉", @"😊", @"🙂", @"🙃", @"☺", @"😋", @"😌", @"😍", @"😘", @"😗", @"😙", @"😚", @"😜", @"😝", @"😛", @"🤑", @"🤓", @"😎", @"🤗", @"😏", @"😶", @"😐", @"😑", @"😒", @"🙄", @"🤔", @"😳", @"😞", @"😟", @"😠", @"😡", @"😔", @"😕", @"🙁", @"☹", @"😣", @"😖", @"😫", @"😩", @"😤", @"😮", @"😱", @"😨", @"😰", @"😯", @"😦", @"😧", @"😢", @"😥", @"😪", @"😓", @"😭", @"😵", @"😲", @"🤐", @"😷", @"🤒", @"🤕", @"😴", @"🙌", @"👏", @"👋", @"👍", @"👊", @"✊", @"✌", @"👌", @"✋", @"💪", @"🙏", @"☝", @"👆", @"👇", @"👈", @"👉", @"🖕", @"🤘", @"🖖", @"✍", @"💅", @"👄", @"👅", @"👂", @"👃", @"👁"])

//字体名称(http://iosfonts.com/ | https://fonts.google.com/)
#define Default_FontNames @[@"Helvetica",@"STLiti",@"HelveticaNeue-CondensedBold",@"Helvetica-Light",@"HelveticaNeue-Thin",@"MarkerFelt-Thin",@"Noteworthy-Light",@"Menlo-Regular",@"SavoyeLetPlain",@"SnellRoundhand-Bold",@"momo_xinjian",@"LiuJiang-Cao-1.0",@"QXyingbixing",@"LiDeBiao-Xing-3.0",@"AnJingCheng-Xing-2.0",@"zhongqi-Wangqinghua"]


@class LWDrawToolsView;
@class LWTileHeader;
@class PHAsset;
@class LWDrawView;
@class LWDrawBar;


@interface LWDrawBar : UIView

@property(nonatomic,strong) LWDrawToolsView *drawToolsView;

+ (LWDrawBar *)drawBarWithFrame:(CGRect)frame;

@end

#pragma mark - LWDrawToolsView

@interface LWDrawToolsView : UICollectionView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

+ (LWDrawToolsView *)toolView;

@end

@interface LWToolsCell:UICollectionViewCell

@property(nonatomic, strong) UIButton *btn;

@end

@interface LWToolsSliderCell:UICollectionViewCell

@property(nonatomic, strong) UISlider *slider;

@end


#pragma mark - LWColorSelectorView

@interface LWColorSelectorView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

+(LWColorSelectorView *)showColorSelectorViewInView:(UIView *)view;

@end

@interface LWColorCell:UICollectionViewCell

@property(nonatomic, strong) UIView *colorView;

@property(nonatomic,assign) NSInteger colorIndex;

@end


#pragma mark - LWTileImagesView

@interface LWTileImagesView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) LWTileHeader *tileHeader;
@property(nonatomic, assign) DrawType currentDrawType;

@property(nonatomic, strong) NSArray *itemsData;

+(LWTileImagesView *)showTileImagesView:(UIView *)view;

@end

@interface LWTileCell:UICollectionViewCell

@property(nonatomic, strong) UIImageView *imageView;

//@property(nonatomic, strong) NSURL *imageUrl;

@end


@interface LWTileHeader : UICollectionReusableView

@property(nonatomic, strong) UIButton *tileBtn;

@end


#pragma mark - LWFontSelectorView

@interface LWFontSelectorView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

+(LWFontSelectorView *)showFontSelectorView:(UIView *)view;

@end

@interface LWFontCell:UICollectionViewCell

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic,assign) NSString *fontName;

@end