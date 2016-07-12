//
//  UIBarButtonItem+MCBtn.m
//  ZhiZhu
//
//  Created by 周陆洲 on 15/12/7.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import "UIBarButtonItem+MCBtn.h"

@implementation UIBarButtonItem (MCBtn)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    button.adjustsImageWhenHighlighted = NO;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
