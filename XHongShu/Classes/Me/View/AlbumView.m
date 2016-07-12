//
//  AlbumView.m
//  XHongShu
//
//  Created by 宋江 on 16/6/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "AlbumView.h"

@implementation AlbumView
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self createUI:frame];
    }
    return self;
}
- (void)createUI:(CGRect)frame{

    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 5;
    backView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    backView.layer.borderWidth = 2;
    backView.clipsToBounds = YES;
    [self addSubview:backView];
    
    //专辑名
    _albumNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, frame.size.width - 16, 20)];
    _albumNameLabel.text = @"个人专辑";
    _albumNameLabel.font = [UIFont systemFontOfSize:12];
    _albumNameLabel.textColor = [UIColor blackColor];
    [backView addSubview:_albumNameLabel];
    
    //笔记数量
    _notesLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(_albumNameLabel.frame) +4,  frame.size.width - 16, 20)];
    _notesLabel.textColor = [UIColor grayColor];
    _notesLabel.font = [UIFont systemFontOfSize:12];
    _notesLabel.text = [NSString stringWithFormat:@"共1篇笔记"];
    [backView addSubview:_notesLabel];
    
    UIImageView *imageView1= [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_notesLabel.frame)+8,  frame.size.width/2-1, frame.size.width/2-1)];
    imageView1.image = [UIImage imageNamed:@"user"];
    [backView addSubview:imageView1];
    
    UIImageView *imageView2= [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2+1, CGRectGetMaxY(_notesLabel.frame)+8,  frame.size.width/2-1, frame.size.width/2-1)];
    imageView2.image = [UIImage imageNamed:@"user"];
    [backView addSubview:imageView2];
    
    UIImageView *imageView3= [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame)+2,  frame.size.width/2-1, frame.size.width/2-1)];
    imageView3.image = [UIImage imageNamed:@"user"];
    [backView addSubview:imageView3];
    
    UIImageView *imageView4= [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2+1, CGRectGetMaxY(imageView1.frame)+2,  frame.size.width/2-1, frame.size.width/2-1)];
    imageView4.image = [UIImage imageNamed:@"user"];
    [backView addSubview:imageView4];
   
}
@end
