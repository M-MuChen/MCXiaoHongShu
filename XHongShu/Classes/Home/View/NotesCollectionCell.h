//
//  NotesCollectionCell.h
//  XHongShu
//
//  Created by 周陆洲 on 16/6/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SetItemSize)(CGSize itemSize);

@class GoodsListModel;
@class CollectionCellFrame;
@interface NotesCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *itemImage;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *introductLabel;
@property (strong, nonatomic) IBOutlet UILabel *tagLabel;
@property (strong, nonatomic) IBOutlet UIImageView *itemMore;
@property (strong, nonatomic) IBOutlet UIImageView *userHead;
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *likeNumLabel;
@property (strong, nonatomic) IBOutlet UIButton *likeBtn;

@property (copy, nonatomic)SetItemSize setItemSize;

@property (strong, nonatomic) GoodsListModel *goodsModel;
@property (strong, nonatomic) CollectionCellFrame *frameModel;
@property (assign, nonatomic) CGSize itemSize;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)reuseIdentifier;

@end
