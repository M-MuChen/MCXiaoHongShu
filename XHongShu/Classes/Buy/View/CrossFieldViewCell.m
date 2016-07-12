//
//  CrossFieldViewCell.m
//  XHongShu
//
//  Created by 宋江 on 16/7/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "CrossFieldViewCell.h"
#import "CrossFieldCollectionView.h"
#import <UIImageView+WebCache.h>
@interface CrossFieldViewCell()
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)CrossFieldCollectionView *crossFieldView;

@end
@implementation CrossFieldViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
     _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
     [self.contentView  addSubview:_imageView];
    
    _crossFieldView = [[CrossFieldCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), SCREEN_WIDTH,160)];
    [self.contentView addSubview:_crossFieldView];
    
}

- (void)setEventModel:(Event *)eventModel{

    _eventModel = eventModel;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_eventModel.image]];
    _crossFieldView.eventModel = _eventModel;
}
@end
