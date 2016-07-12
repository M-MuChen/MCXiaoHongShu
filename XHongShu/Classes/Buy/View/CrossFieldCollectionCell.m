//
//  CrossFieldCollectionCell.m
//  XHongShu
//
//  Created by 宋江 on 16/6/17.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "CrossFieldCollectionCell.h"
#import <UIImageView+WebCache.h>
@implementation CrossFieldCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"CrossFieldCollectionCell" owner:self options:nil];
        self = [array lastObject];
    }
    return self;
}
- (void)setGoodsList:(GoodsList *)goodsList{
    _goodsList = goodsList;
    self.name.text  = _goodsList.title;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_goodsList.image]];
    self.price.text = [NSString stringWithFormat:@"￥%@ ￥%@",_goodsList.discountPrice,_goodsList.price];
}
@end
