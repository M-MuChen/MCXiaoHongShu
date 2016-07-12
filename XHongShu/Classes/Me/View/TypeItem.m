//
//  TypeItem.m
//  XHongShu
//
//  Created by 宋江 on 16/6/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "TypeItem.h"

@implementation TypeItem

/**
 *  初始化Item
 *
 *  @param imageStr 图片名
 *  @param title    标题
 *
 */

-(instancetype)initWithImage:(NSString *)imageStr title:(NSString *)title
{
    if (self = [super init]) {
        
        [self createItemWithImage:imageStr title:title];
        
    }
    return self;
}

//绘制问答item
-(void)createItemWithImage:(NSString *)imageStr title:(NSString *)title
{
    UIImageView *itemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 40, 40)];
    itemImageView.layer.cornerRadius = 20;
    itemImageView.clipsToBounds = YES;
    itemImageView.image = [UIImage imageNamed:imageStr];
    [self addSubview:itemImageView];
    
    UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, itemImageView.bounds.size.height + 8, 50, 16)];
    itemLabel.text = title;
    itemLabel.font = [UIFont systemFontOfSize:13];
    itemLabel.textColor = MCColor(55, 55, 55, 1.0);
    itemLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:itemLabel];
}


@end
