//
//  SJButton.m
//  XHongShu
//
//  Created by 宋江 on 16/6/3.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "SJButton.h"

@implementation SJButton

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //可根据自己的需要随意调整
        
        self.titleLabel.textAlignment=NSTextAlignmentRight;
        
        self.titleLabel.font=[UIFont systemFontOfSize:14.0];
        
        self.imageView.contentMode=UIViewContentModeCenter;
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];

        
    }
    
    return self;
    
}

//重写父类UIButton的方法

//更具button的rect设定并返回文本label的rect

- (CGRect)titleRectForContentRect:(CGRect)contentRect

{
    
    CGFloat titleW = contentRect.size.width-30;
    
    CGFloat titleH = contentRect.size.height;
    
    CGFloat titleX = 0;
    
    CGFloat titleY = 0;
    
    
    
    contentRect = (CGRect){{titleX,titleY},{titleW,titleH}};
    
    return contentRect;
    
}

//更具button的rect设定并返回UIImageView的rect

- (CGRect)imageRectForContentRect:(CGRect)contentRect

{
    
    CGFloat imageW = 7;
    
    CGFloat imageH = 25;
    
    CGFloat imageX = contentRect.size.width-26;
    
    CGFloat imageY = 2.5;
    
    
    
    contentRect = (CGRect){{imageX,imageY},{imageW,imageH}};
    
    return contentRect;
    
}

@end
