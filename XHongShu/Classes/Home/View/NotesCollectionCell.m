//
//  NotesCollectionCell.m
//  XHongShu
//
//  Created by 周陆洲 on 16/6/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "NotesCollectionCell.h"
//#import "GoodsListModel.h"
#import "CollectionCellFrame.h"
#import "ImagesList.h"
#import "Recommend.h"
#import "User.h"
#import <UIImageView+WebCache.h>

@interface NotesCollectionCell()

@end
@implementation NotesCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier
{
    NotesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[NotesCollectionCell alloc]init];
    }
    
    return cell;
}

//-(void)setGoodsModel:(GoodsListModel *)goodsModel
//{
//    if (!_goodsModel) {
//        _goodsModel = [[GoodsListModel alloc] init];
//    }
//    _goodsModel = goodsModel;
//    
//    [self setData];
//}

-(void)setFrameModel:(CollectionCellFrame *)frameModel
{
    if (!_frameModel) {
        _frameModel = [[CollectionCellFrame alloc] init];
    }
    _frameModel = frameModel;
    [self setData];
}

-(void)setData
{
//    NSDictionary *imageDic = self.goodsModel.imagesList[0];
//    
//    ImagesList *imageList = [[ImagesList alloc]initWithDictionary:imageDic error:nil];
//    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageList.url]];
//    UIImage *img = [UIImage imageWithData:imgData];
    
    _itemImage.image = self.frameModel.itemImage;

    _itemImage.size = CGSizeMake(_itemImage.size.width, self.frameModel.imageH);
    
    self.introductLabel.text = self.frameModel.goodsModel.desc;
    
    Recommend *recommendModel = self.frameModel.goodsModel.recommend;
    self.tagLabel.text = recommendModel.desc;
    
    User *userModel = self.frameModel.goodsModel.user;
    [self.userHead sd_setImageWithURL:[NSURL URLWithString:userModel.images]];
    
    self.nickName.text = userModel.nickname;
    
    self.likeNumLabel.text = [NSString stringWithFormat:@"%@",self.frameModel.goodsModel.likes];
}

@end
