//
//  MCWaterFlowLayout.h
//  XHongShu
//
//  Created by 周陆洲 on 16/6/27.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCWaterFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>
@optional
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout columnCountForSection:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section;
- (void)beginLoadContentSize:(CGSize)size;
@end

@interface MCWaterFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) NSInteger columnCount; // default 2
@property (nonatomic, assign) CGFloat headerHeight; // default 0
@property (nonatomic, assign) CGFloat footerHeight; // default 0
/** contentsize的高度*/
@property (nonatomic, assign) CGFloat contentHeight;

//@property (nonatomic, assign) UIEdgeInsets mcSectionInset;
//@property (nonatomic, assign) CGFloat mcMinimumInteritemSpacing;
//@property (nonatomic, assign) CGFloat mcMinimumLineSpacing;

@end
