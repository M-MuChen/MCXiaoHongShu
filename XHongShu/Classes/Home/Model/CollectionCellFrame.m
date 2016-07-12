//
//  CollectionCellFrame.m
//  XHongShu
//
//  Created by 周陆洲 on 16/6/3.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "CollectionCellFrame.h"
#import "ImagesList.h"

static CGFloat const padding = 10;
@implementation CollectionCellFrame

-(void)setGoodsModel:(GoodsListModel *)goodsModel
{
    _goodsModel = goodsModel;
    NSDictionary *imageDic = self.goodsModel.imagesList[0];
    ImagesList *imageList = [[ImagesList alloc]initWithDictionary:imageDic error:nil];
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageList.url]];
    self.itemImage = [UIImage imageWithData:imgData];
    
    CGFloat itemW = (SCREEN_WIDTH - 3*padding)/2;
    self.imageH = itemW/self.itemImage.size.width * self.itemImage.size.height;
    CGFloat itemH = 250 - 135 + _imageH;
    self.itemSize = CGSizeMake(itemW, itemH);
}

@end
