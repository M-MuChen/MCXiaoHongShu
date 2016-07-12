//
//  MCRefreshHeader.m
//  XHongShu
//
//  Created by 周陆洲 on 16/6/3.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MCRefreshHeader.h"

@interface MCRefreshHeader()

@property (weak, nonatomic) UIImageView *animateView;

@end
@implementation MCRefreshHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    // 设置控件的高度
    self.mj_h = 40;
    
    UIImageView *animateView = [[UIImageView alloc]init];
    NSArray *imageNameArray = @[@"xy_loading_1~iphone",@"xy_loading_1~iphone",@"xy_loading_2~iphone",@"xy_loading_3~iphone",@"xy_loading_4~iphone",@"xy_loading_5~iphone",@"xy_loading_6~iphone",@"xy_loading_7~iphone",@"xy_loading_8~iphone",@"xy_loading_9~iphone",@"xy_loading_10~iphone",@"xy_loading_11~iphone",@"xy_loading_12~iphone",@"xy_loading_13~iphone",@"xy_loading_14~iphone",@"xy_loading_15~iphone",@"xy_loading_16~iphone",@"xy_loading_17~iphone",@"xy_loading_18~iphone",@"xy_loading_19~iphone",@"xy_loading_20~iphone",@"xy_loading_21~iphone",@"xy_loading_22~iphone",@"xy_loading_23~iphone",@"xy_loading_24~iphone",@"xy_loading_25~iphone",@"xy_loading_26~iphone",@"xy_loading_27~iphone",@"xy_loading_28~iphone",@"xy_loading_29~iphone",@"xy_loading_30~iphone",@"xy_loading_31~iphone",@"xy_loading_32~iphone"];
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSString *imageStr in imageNameArray) {
        UIImage *image = [UIImage imageNamed:imageStr];
        [imageArray addObject:image];
    }
    
    animateView.animationImages = imageArray;
    animateView.animationDuration = 3.0;
//    animateView.animationRepeatCount = MAXFLOAT;
    [self addSubview:animateView];
    self.animateView = animateView;
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.animateView.bounds = CGRectMake(0, 0, 32, 32);
    self.animateView.center = CGPointMake(self.mj_w * 0.5, - self.mj_h * 0.5+45);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    CGPoint contentSet = [change[@"new"] CGPointValue];
    
    if (contentSet.y >= -30.0 && contentSet.y < -20) {
        _animateView.image = [UIImage imageNamed:@"xy_loading_s_1~iphone"];
    }else if (contentSet.y >= -40.0 && contentSet.y < -30.0){
        _animateView.image = [UIImage imageNamed:@"xy_loading_s_2~iphone"];
    }else if (contentSet.y >= -50.0 && contentSet.y < -40.0){
        _animateView.image = [UIImage imageNamed:@"xy_loading_s_3~iphone"];
    }else if (contentSet.y >= -60.0 && contentSet.y < -50.0){
        _animateView.image = [UIImage imageNamed:@"xy_loading_s_4~iphone"];
    }
//    NSLog(@"********* %@,  %lf",change,contentSet.y);
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.animateView stopAnimating];
            break;
        case MJRefreshStatePulling:
            [self.animateView stopAnimating];
            break;
        case MJRefreshStateRefreshing:
            [self.animateView startAnimating];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
//    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}




@end





