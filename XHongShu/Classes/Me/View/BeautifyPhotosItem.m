//
//  BeautifyPhotosItem.m
//  XHongShu
//
//  Created by 宋江 on 16/7/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BeautifyPhotosItem.h"

@implementation BeautifyPhotosItem

- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)imageName andName:(NSString *)name{
    self = [super initWithFrame:frame];
    if (self) {
        [self createImageName:imageName andName:name];
    }
    return self;
}
- (void)createImageName:(NSString *)imageName andName:(NSString *)name{
    
    UIImageView *itemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    itemImageView.layer.cornerRadius = 20;
//    itemImageView.clipsToBounds = YES;
    itemImageView.image = [UIImage imageNamed:imageName];
    [self addSubview:itemImageView];
    
    UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, itemImageView.bounds.size.height + 8, 50, 15)];
    itemLabel.font = [UIFont systemFontOfSize:12];
    itemLabel.textColor = [UIColor grayColor];
    itemLabel.textAlignment = NSTextAlignmentCenter;
    itemLabel.text = name;
    [self addSubview:itemLabel];

}
@end
