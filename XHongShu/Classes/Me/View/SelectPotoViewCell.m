//
//  SelectPotoViewCell.m
//  XHongShu
//
//  Created by 宋江 on 16/7/4.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "SelectPotoViewCell.h"

@implementation SelectPotoViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
   _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,(SCREEN_WIDTH - 16)/3 , (SCREEN_WIDTH - 16)/3)];
    [self.contentView addSubview:_imageView];
}
@end
