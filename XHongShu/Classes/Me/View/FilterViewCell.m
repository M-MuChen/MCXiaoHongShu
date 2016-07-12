//
//  FilterViewCell.m
//  XHongShu
//
//  Created by 宋江 on 16/7/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "FilterViewCell.h"
#import "Auxiliary.h"
@implementation FilterViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,90, 90)];
    [self.contentView addSubview:_imageView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 90, 30)];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLabel];
}

@end
