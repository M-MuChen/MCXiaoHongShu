//
//  EditPotoCollectionView.m
//  XHongShu
//
//  Created by 宋江 on 16/6/8.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "EditPotoCollectionView.h"
#import "Auxiliary.h"
#import "FilterViewCell.h"
#import <UIImageView+WebCache.h>
@interface EditPotoCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *aryLJ;
@end
@implementation EditPotoCollectionView
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {

        _dataArray = [NSArray array];
        _aryLJ = [NSMutableArray array];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        //水平滑动
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        [_collectionView registerClass:[FilterViewCell class] forCellWithReuseIdentifier:@"FilterCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = MCColor(248, 248, 248, 1.0);
        [self addSubview:_collectionView];
    }
    return self;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    FilterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCell" forIndexPath:indexPath];
    cell.imageView.image = [Auxiliary changeImage:(int)indexPath.row imageView:[UIImage imageNamed:_aryLJ[indexPath.row]]];

    cell.nameLabel.text = _dataArray[indexPath.row];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(90,90);
}
- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(4, 4,60, 4);

}
//collectionViewcell之间的高度
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 4;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate SpecialEffectsIndex:indexPath.row];
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    for (int i = 0 ; i< _dataArray.count; i++) {
        [_aryLJ addObject:@"123"];
    }
}

@end
