
//
//  AllAlbumViewController.m
//  XHongShu
//
//  Created by 宋江 on 16/6/3.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "AllAlbumViewController.h"
#import "AlbumView.h"
@interface AllAlbumViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_allAlbumView;
}
@end

@implementation AllAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self barbtnItem];
    [self createUI];
}
- (void)barbtnItem{
    UIBarButtonItem *userItem = [UIBarButtonItem itemWithImageName:@"navi_back~iphone" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = userItem;
    
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(add)];

    self.navigationItem.rightBarButtonItem = setItem;
}

- (void)createUI{
    self.navigationItem.title = @"我的专辑";
    _allAlbumView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    _allAlbumView.backgroundColor = [UIColor whiteColor];
    _allAlbumView.delegate = self;
    _allAlbumView.dataSource = self;
    _allAlbumView.scrollEnabled = YES;
    [_allAlbumView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"allAlbumCell"];
    [self.view addSubview:_allAlbumView];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [_allAlbumView dequeueReusableCellWithReuseIdentifier:@"allAlbumCell" forIndexPath:indexPath];
    AlbumView * albumView = [[AlbumView alloc]initWithFrame:CGRectMake(0, 0, (VIEW_WEDTH - 30)/2, 227)];
    [cell addSubview:albumView];

    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((VIEW_WEDTH - 30)/2, 227);
}
- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//collectionViewcell之间的高度
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        
    }else{
        
    }
    
}
#pragma mark 返回上一页
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 添加专辑
- (void)add{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
