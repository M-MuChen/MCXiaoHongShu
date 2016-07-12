//
//  FollowTagsCell.m
//  XHongShu
//
//  Created by 宋江 on 16/6/3.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "FollowTagsCell.h"
#import <UIImageView+WebCache.h>
@interface FollowTagsCell()
{
    UIImageView *_imageView;
    UILabel *_nameLabel;
}
@end
@implementation FollowTagsCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCell:frame];
    }
    return self;
}
- (void)createCell:(CGRect)frame{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,frame.size.width ,frame.size.height)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 5;
    backView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    backView.layer.borderWidth = 1;
    backView.clipsToBounds = YES;
    [self addSubview:backView];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,frame.size.width ,frame.size.width - 30)];
    [backView addSubview:_imageView];
    
    //笔记数量
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame),frame.size.width,30)];
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:_nameLabel];

}
- (void)setFollowTagsModel:(FollowTagsModel *)followTagsModel{
    _followTagsModel =  followTagsModel;
    [self setValue];
}
- (void)setValue{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_followTagsModel.image]];
     _nameLabel.text = _followTagsModel.name;
}
@end
