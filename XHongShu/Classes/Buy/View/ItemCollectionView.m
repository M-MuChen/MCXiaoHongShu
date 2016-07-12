//
//  ItemCollectionView.m
//  XHongShu
//
//  Created by 宋江 on 16/6/29.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "ItemCollectionView.h"
#import "itemCollectionViewCell.h"
@interface ItemCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *itemCollectionView;

@end
@implementation ItemCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = [NSArray array];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        //水平滑动
        _itemCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        [_itemCollectionView registerClass:[itemCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _itemCollectionView.delegate = self;
        _itemCollectionView.dataSource = self;
        _itemCollectionView.backgroundColor = [UIColor whiteColor];

        [self addSubview:_itemCollectionView];
    }
    return self;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    itemCollectionViewCell *cell = [_itemCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.categoryModel = [_dataArray objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell.selectedLine.backgroundColor = [UIColor redColor];
    }else{
        cell.selectedLine.backgroundColor = [UIColor whiteColor];
    }

    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-2)/4,40);
}
- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0,0, 0);
    
}
//collectionViewcell之间的高度
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.01f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01f;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for (itemCollectionViewCell *cell in _itemCollectionView.visibleCells) {
        cell.selectedLine.backgroundColor = [UIColor whiteColor];

    }
    itemCollectionViewCell *cell = [_itemCollectionView cellForItemAtIndexPath:indexPath];
    cell.selectedLine.backgroundColor = [UIColor redColor];
    cell.selected = YES;
    [self.itemDelegate changeItem:indexPath.row];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    itemCollectionViewCell *cell = [_itemCollectionView cellForItemAtIndexPath:indexPath];
    cell.selectedLine.backgroundColor = [UIColor whiteColor];
    cell.selected = NO;
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
}
@end
