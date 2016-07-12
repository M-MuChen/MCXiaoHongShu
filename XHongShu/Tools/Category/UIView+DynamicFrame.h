//
//  UIView+DynamicFrame.h
//  ZhiZhu
//
//  Created by 周陆洲 on 15/12/10.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MCDynamicChangeType) {
    MCDynamicChangeType_X,      //x坐标不变，width动态变化
    MCDynamicChangeType_Width,  //width不变，x动态变化
    MCDynamicChangeType_X_Width,
};

@interface UIView (DynamicFrame)

/**
 *  控件尺寸随屏幕尺寸动态变化
 *
 *  @param width  宽
 *  @param height 高
 */
-(void)setFrameWithWidth:(CGFloat)width Height:(CGFloat)height;

/**
 *  控件坐标随屏幕尺寸动态变化
 *
 *  @param X x
 *  @param Y y
 */
-(void)setFrameWithX:(CGFloat)X Y:(CGFloat)Y;

/**
 *  根据屏幕尺寸动态设置空间尺寸大小
 *
 *  @param width          控件宽
 *  @param height         控件高
 *  @param X              x坐标
 *  @param Y              y坐标
 *  @param verticalMargin 相对于上方控件的距离
 *  @param type           选择X坐标固定还是控件宽度固定
 */
-(void)setFrameWithWidth:(CGFloat)width Height:(CGFloat)height X:(CGFloat)X Y:(CGFloat)Y verticalMargin:(CGFloat)verticalMargin horizonMargin:(CGFloat)horizonMargin changeType:(MCDynamicChangeType)type;


@end
