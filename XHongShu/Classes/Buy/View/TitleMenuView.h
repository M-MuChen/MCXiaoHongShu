//
//  TitleMenuView.h
//  TitleMenuView
//
//  Created by luochen on 16/5/20.
//  Copyright © 2016年 luochen. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define mainWidth    [UIScreen mainScreen].bounds.size.width
//#define mainHeight   [UIScreen mainScreen].bounds.size.height
@interface TitleMenuView : UIView<UIScrollViewDelegate>

{
    UIScrollView *mainScrollView;
    UIScrollView *vcScrollView;
    UIView *btnSliderView;
    NSMutableArray *buttonsArray;
    NSArray *vcsArray;
    CGFloat btnWidth;
    CGFloat btnSpace;
    CGFloat titleFont;
}

typedef NS_ENUM(NSInteger, TitleMenuScrollViewStyle)
{
    TitleMenuStyleDefault,
    TitleMenuStylePlayGround,
    TitleMenuStyleLine
};

//样式
@property (nonatomic, assign) TitleMenuScrollViewStyle viewStyle;
//按钮字体的默认颜色
@property (nonatomic, strong) UIColor *btnNormalColor;
//按钮选中时字体的颜色
@property (nonatomic, strong) UIColor *btnSelectedColor;
//标题栏的背景颜色
@property (nonatomic, strong) UIColor *titleMenuBackGroundColor;
//滚动条的颜色
@property (nonatomic, strong) UIColor *sliderColor;

- (instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSArray *)array WithStyle:(TitleMenuScrollViewStyle)titleMenuStyle WithTitleFont:(CGFloat)font AndTitleInterval:(CGFloat)space;

@end
