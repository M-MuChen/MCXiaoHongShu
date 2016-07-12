//
//  ControlBar.m
//  ZhiZhu
//
//  Created by 宋江 on 16/3/9.
//  Copyright © 2016年 wt-vrs. All rights reserved.
//

#import "ControlBar.h"

@implementation ControlBar

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

    //标题
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,self.width,self.height)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = name;
    _nameLabel.font = [UIFont fontWithName:@"Arial" size:17.0];
    [self addSubview:_nameLabel];
    
}

@end
