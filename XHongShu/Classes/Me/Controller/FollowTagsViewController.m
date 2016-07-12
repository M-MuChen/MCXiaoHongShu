//
//  FollowTagsViewController.m
//  XHongShu
//
//  Created by 宋江 on 16/6/3.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "FollowTagsViewController.h"
#import "FollowTagsCell.h"
#import "FollowTagsModel.h"
@interface FollowTagsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_followTagsView;
    NSMutableArray *_followTagsArray;
}
@end

@implementation FollowTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self barbtnItem];
    [self getFollowTagData];
}
- (void)barbtnItem{
    UIBarButtonItem *userItem = [UIBarButtonItem itemWithImageName:@"navi_back~iphone" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = userItem;
    
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItem = setItem;
}

/**
 *  获取用户信息数据
 **/
- (void)getFollowTagData{
    _followTagsArray = [NSMutableArray array];
    [MCNetworkingLogin getLogin:followTagsString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *dataArray = responseObject[@"data"];
        _followTagsArray = [FollowTagsModel arrayOfModelsFromDictionaries:dataArray];
        [self createUI];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}
- (void)createUI{
    self.navigationItem.title = @"我的专辑";

    _followTagsView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WEDTH, VIEW_HEIGHT -64 -49) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];

    _followTagsView.backgroundColor = [UIColor whiteColor];
    _followTagsView.delegate = self;
    _followTagsView.dataSource = self;
    [_followTagsView registerClass:[FollowTagsCell class] forCellWithReuseIdentifier:@"followTagsCell"];
    [self.view addSubview:_followTagsView];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FollowTagsCell *cell = [_followTagsView dequeueReusableCellWithReuseIdentifier:@"followTagsCell" forIndexPath:indexPath];
    cell.followTagsModel = _followTagsArray[indexPath.row];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _followTagsArray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((VIEW_WEDTH - 40.5)/3, (VIEW_WEDTH - 40.5)/3);
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
    
    
}
#pragma mark 返回上一页
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 编辑
- (void)edit{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
