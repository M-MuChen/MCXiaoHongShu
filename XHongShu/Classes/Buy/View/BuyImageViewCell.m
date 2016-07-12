//
//  BuyImageViewCell.m
//  XHongShu
//
//  Created by 宋江 on 16/7/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BuyImageViewCell.h"
#import <UIImageView+WebCache.h>
@interface BuyImageViewCell()
@property (nonatomic,strong)UIImageView *imageView;

@end
@implementation BuyImageViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [self.contentView addSubview:_imageView];
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [_imageView sd_setImageWithURL:[NSURL URLWithString: _dataArray[0][@"image"]]];
}
@end
