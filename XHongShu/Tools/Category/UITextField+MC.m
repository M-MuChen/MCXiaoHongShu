//
//  UITextField+MC.m
//  ZhiZhu
//
//  Created by 宋江 on 15/12/10.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import "UITextField+MC.h"

@implementation UITextField (MC)

/**
 *  创建一个textField
 *
 *  @param imageName   图片名
 *  @param placeHolder 占位字符串
 */
-(void)createTextFieldWithImage:(NSString *)imageName placeHolder:(NSString *)placeHolder
{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self leftViewRectForBounds:CGRectMake(0, 0, 32, 32)];
    [self drawPlaceholderInRect:CGRectMake(100, 0, self.frame.size.width-60, self.frame.size.height)];
    self.leftView = leftImageView;
    self.clearButtonMode =  YES;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.placeholder = placeHolder;
    self.layer.borderWidth = 1;
    self.layer.borderColor = MCColor(191, 193, 194, 1.0).CGColor;
    self.layer.cornerRadius = 3;
}

@end
