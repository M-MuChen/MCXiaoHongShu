//
//  FollowItem.m
//  XHongShu
//
//  Created by 宋江 on 16/6/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "FollowItem.h"

@implementation FollowItem

- (instancetype)initWithName:(NSString *)name size:(CGSize)size{
    self = [super init];
    if (self) {
        [self createControlBarWithName:name size:size];
    }
    return self;
}

//创建item
- (void)createControlBarWithName:(NSString *)name size:(CGSize)size{
    
    [self setSize:size];
    
    //数量
    _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 15)];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.adjustsFontSizeToFitWidth = YES;
    _countLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_countLabel];
    
    //标题
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_countLabel.frame) + 2, self.width, 15)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = name;
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.textColor = [UIColor grayColor];
    [self addSubview:_nameLabel];
    
}


@end
