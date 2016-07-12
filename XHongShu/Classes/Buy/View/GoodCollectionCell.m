//
//  GoodCollectionCell.m
//  XHongShu
//
//  Created by 宋江 on 16/6/17.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "GoodCollectionCell.h"
#import <UIImageView+WebCache.h>
@implementation GoodCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"GoodCollectionCell" owner:self options:nil];
        self = [array lastObject];
    }
    return self;
}
- (void)setGoodsListModel:(GoodsListModel *)goodsListModel{
    _goodsListModel = goodsListModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_goodsListModel.image]];
    self.goodName.text = _goodsListModel.title;
    self.goodDes.text = _goodsListModel.desc;
    self.goodPrice.text = [NSString stringWithFormat:@"￥%@",_goodsListModel.discountPrice];
    
}
@end
