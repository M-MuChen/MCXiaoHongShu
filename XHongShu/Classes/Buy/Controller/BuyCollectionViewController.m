//
//  BuyCollectionViewController.m
//  XHongShu
//
//  Created by 宋江 on 16/6/16.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BuyCollectionViewController.h"
#import "GoodCollectionCell.h"
#import "CrossFieldCollectionView.h"
#import "SXNetworkTools.h"
#import "CrossFieldViewCell.h"
#import "BuyImageViewCell.h"
#import <UIImageView+WebCache.h>
@interface BuyCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_buyCollectionView;
    NSMutableArray *_crossFieldArray;
    NSMutableArray *_downCollectionArray;
    NSMutableArray *_crossViewArray;
    NSMutableArray *_cellArray;
}
@property(nonatomic,assign)BOOL update;
@end

@implementation BuyCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(welcome) name:@"SXAdvertisementKey" object:nil];
    _crossViewArray = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    _buyCollectionView  =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, VIEW_HEIGHT - 143) collectionViewLayout:flowLayout];
    _buyCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _buyCollectionView.delegate = self;
    _buyCollectionView.dataSource = self;
    [_buyCollectionView registerClass:[CrossFieldViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [_buyCollectionView registerClass:[GoodCollectionCell class] forCellWithReuseIdentifier:@"GoodCell"];
    [_buyCollectionView registerClass:[BuyImageViewCell class] forCellWithReuseIdentifier:@"ImageCell"];
    [self.view addSubview:_buyCollectionView];
    
    MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _buyCollectionView.mj_header = header;
    self.update = YES;
    
}

-(void)setIndexs:(NSUInteger)indexs
{
    _indexs = indexs;
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return _cellArray.count;
    }else {
        return _downCollectionArray.count;
    }
}
//collectionViewcell之间的高度
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        return 10;
    }else{
        return 10;
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        BuyImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];

//        if (indexPath.row == 0) {
//            [imageView sd_setImageWithURL:[NSURL URLWithString: _crossFieldArray[0][@"image"]]];
//        }else{
//            [imageView sd_setImageWithURL:[NSURL URLWithString: _crossFieldArray[1][@"ads_list"][0][@"image"]]];
//        }
        cell.dataArray = _crossFieldArray;
        return cell;
    }else if (indexPath.section == 1) {
        CrossFieldViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        _recommendGoodsModel =  [[RecommendGoodsModel alloc]initWithDictionary: _cellArray[indexPath.row] error:nil];
        cell.eventModel = _recommendGoodsModel.event;
       return cell;
    }else{
        GoodCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodCell" forIndexPath:indexPath];
        cell.goodsListModel = _downCollectionArray[indexPath.row];
        return cell;

    }

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(VIEW_WEDTH, 200);

    }else if (indexPath.section == 1){
        return CGSizeMake(VIEW_WEDTH, 340);
    }else{
        return CGSizeMake((VIEW_WEDTH - 30)/2, 230);
    }
}
- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(10, 10, 0,10);
    }else if (section == 1){
        return UIEdgeInsetsMake(10, 10, 10,10);
    }else{
        return UIEdgeInsetsMake(20, 10, 10,10);
    }

}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if ([kind isEqualToString: UICollectionElementKindSectionHeader]) {
//        CollectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
//        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, VIEW_HEIGHT*0.6)];
//        
//        _headImageView.image =  _imageArray[0];
//        
//        [headerView addSubview:_headImageView];
//        
//        return headerView;
//    }else{
        return nil;
//    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"哈哈，可以");
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
- (void)welcome
{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"update"];
    [_buyCollectionView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"update"]) {
        return;
    }
    if (self.update == YES) {
        [_buyCollectionView.mj_header beginRefreshing];
        self.update = NO;
    }
}


#pragma mark - /************************* 刷新数据 ***************************/
// ------下拉刷新
- (void)loadData
{
    NSLog(@"ssssssss----------");
    // http://c.m.163.com//nc/article/headline/T1348647853363/0-30.html
//    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    [self loadDataForType:1 withURL:buyCrossFieldString];
}

// ------上拉加载
//- (void)loadMoreData
//{
//    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(self.arrayList.count - self.arrayList.count%10)];
//    //    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,self.arrayList.count];
//    [self loadDataForType:2 withURL:allUrlstring];
//}

// ------公共方法
- (void)loadDataForType:(int)type withURL:(NSString *)allUrlstring
{
        _crossFieldArray = [NSMutableArray array];
        [MCNetworkingLogin getLogin:allUrlstring parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    
            NSArray *dataArray = responseObject[@"data"];
            [_crossFieldArray addObjectsFromArray: dataArray];
            
            _cellArray = [NSMutableArray arrayWithArray:_crossFieldArray];
            [_cellArray removeObjectAtIndex:0];
            [_cellArray removeObjectAtIndex:0];
            [self getDownCollectionData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
            NSLog(@"%@",error);
        }];
    
    
    
}// ------想把这里改成block来着
- (void)getDownCollectionData{

    _downCollectionArray = [NSMutableArray array];
    [MCNetworkingLogin getLogin:buyDownCollectionString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray *dataArray = responseObject[@"data"];
        _downCollectionArray = [GoodsListModel arrayOfModelsFromDictionaries:dataArray];
        [_buyCollectionView.mj_header endRefreshing];
        [_buyCollectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@",error);
    }];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
