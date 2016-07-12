//
//  UIView+DynamicFrame.m
//  ZhiZhu
//
//  Created by 周陆洲 on 15/12/10.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import "UIView+DynamicFrame.h"

@implementation UIView (DynamicFrame)

/**
 *  控件尺寸随屏幕尺寸动态变化
 *
 *  @param width  宽
 *  @param height 高
 */
-(void)setFrameWithWidth:(CGFloat)width Height:(CGFloat)height
{
    if (IOS4) {
        CGFloat w = 320/375.0*width;
        CGFloat h = 480/667.0*height;
        [self setSize:CGSizeMake(w, h)];
    }else if (IOS5){
        CGFloat w = 320/375.0*width;
        CGFloat h = 568/667.0*height;
        [self setSize:CGSizeMake(w, h)];
    }else if (IOS6P){
        CGFloat w = 414/375.0*width;
        CGFloat h = 736/667.0*height;
        [self setSize:CGSizeMake(w, h)];
    }else{
        [self setSize:CGSizeMake(width, height)];
    }
}

/**
 *  控件坐标随屏幕尺寸动态变化
 *
 *  @param X x
 *  @param Y y
 */
-(void)setFrameWithX:(CGFloat)X Y:(CGFloat)Y
{
    if (IOS4) {
        CGFloat x = 320/375.0*X;
        CGFloat y = 480/667.0*Y;
        [self setOrigin:CGPointMake(x, y)];
    }else if (IOS5){
        CGFloat x = 320/375.0*X;
        CGFloat y = 568/667.0*Y;
        [self setOrigin:CGPointMake(x, y)];
    }else if (IOS6P){
        CGFloat x = 414/375.0*X;
        CGFloat y = 736/667.0*Y;
        [self setOrigin:CGPointMake(x, y)];
    }else{
        [self setOrigin:CGPointMake(X, Y)];
    }
}


/**
 *  根据屏幕尺寸动态设置空间尺寸大小
 *
 *  @param width          控件宽
 *  @param height         控件高
 *  @param X              x坐标，左方前一个控件末端的最大X值（若左方无控件，则为自身x坐标）
 *  @param Y              y坐标，上方前一个控件末端的最大y值
 *  @param verticalMargin 相对于上方控件的距离
 *  @param horizonMargin 相对于左方控件的距离
 *  @param type           选择X坐标固定还是控件宽度固定
 */
-(void)setFrameWithWidth:(CGFloat)width Height:(CGFloat)height X:(CGFloat)X Y:(CGFloat)Y verticalMargin:(CGFloat)verticalMargin horizonMargin:(CGFloat)horizonMargin changeType:(MCDynamicChangeType)type
{
    if (IOS4) {
        CGFloat vMargin = 480/667.0*verticalMargin;
        CGFloat hMargin = 320/375.0*horizonMargin;
        CGFloat x;
        CGFloat w;
        if (type == MCDynamicChangeType_X) {
            x = 320/375.0*X;
            w = (SCREEN_WIDTH-2*x);
            
        }else if (type == MCDynamicChangeType_Width){
            w = 320/375.0*width;
            x = (SCREEN_WIDTH - w)/2;
        }else if (type == MCDynamicChangeType_X_Width){
            x = 320/375.0*X;
            w = 320/375.0*width;
        }
        x += hMargin;
        CGFloat h = 480/667.0*height;
        CGFloat y = Y + vMargin;
        
        [self setFrame:CGRectMake(x, y, w, h)];
    }else if (IOS5){
        CGFloat vMargin = 568/667.0*verticalMargin;
        CGFloat hMargin = 320/375.0*horizonMargin;
        CGFloat x;
        CGFloat w;
        if (type == MCDynamicChangeType_X) {
            x = 320/375.0*X;
            w = (SCREEN_WIDTH-2*x);
        }else if (type == MCDynamicChangeType_Width){
            w = 320/375.0*width;
            x = (SCREEN_WIDTH-w)/2;
        }else if (type == MCDynamicChangeType_X_Width){
            x = 320/375.0*X;
            w = 320/375.0*width;
        }
        x += hMargin;
        CGFloat y =  Y +vMargin;
        CGFloat h = 568/667.0*height;
        
        [self setFrame:CGRectMake(x, y, w, h)];
    }else if (IOS6P){
        CGFloat vMargin = 736/667.0*verticalMargin;
        CGFloat hMargin = 414/375.0*horizonMargin;
        CGFloat x;
        CGFloat w;
        if (type == MCDynamicChangeType_X) {
            x = 414/375.0*X;
            w = (SCREEN_WIDTH-2*x);
        }else if (type == MCDynamicChangeType_Width){
            w = 414/375.0*width;
            x = (SCREEN_WIDTH-w)/2;
        }else if (type == MCDynamicChangeType_X_Width){
            x = 414/375.0*X;
            w = 414/375.0*width;
        }
        x += hMargin;
        CGFloat y = Y + vMargin;
        CGFloat h = 736/667.0*height;
        
        [self setFrame:CGRectMake(x, y, w, h)];
    }else{
        [self setFrame:CGRectMake(X + horizonMargin,Y + verticalMargin, width, height)];
    }
}

@end












