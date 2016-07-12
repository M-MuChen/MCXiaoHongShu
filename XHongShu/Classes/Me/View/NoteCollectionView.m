//
//  noteCollectionView.m
//  XHongShu
//
//  Created by 宋江 on 16/6/2.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "noteCollectionView.h"

#define NOTE_CELL @"notye_Cell"
@interface NoteCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_noteCollectionView;
}
@end
@implementation NoteCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createCollection:frame];
    }
    return self;
}
- (void)createCollection:(CGRect)frame{
    _noteCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    _noteCollectionView.backgroundColor = [UIColor whiteColor];
    _noteCollectionView.delegate = self;
    _noteCollectionView.dataSource = self;
    _noteCollectionView.scrollEnabled = YES;
    [_noteCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NOTE_CELL];
    [self addSubview:_noteCollectionView];
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [_noteCollectionView dequeueReusableCellWithReuseIdentifier:NOTE_CELL forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,(SCREEN_WIDTH - 6)/3 , (SCREEN_WIDTH - 6)/3)];
    if (indexPath.row == 0) {
        
        UIImageView *potoImage = [[UIImageView alloc]init];
        potoImage.size = CGSizeMake(60, 60);
        potoImage.center = imageView.center;
        potoImage.image = [UIImage imageNamed:@"xyvg_placeholder_note~iphone"];
        [imageView addSubview:potoImage];
      
    }else{
        imageView.image = [UIImage imageNamed:@"user.png"];
    }
    [cell addSubview:imageView];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - 6)/3, (SCREEN_WIDTH - 6)/3);
}
- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 3, 0);
}
//collectionViewcell之间的高度
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 3;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        [self.delegate selectPhones];
    }else{
    
    }
    
}
@end
