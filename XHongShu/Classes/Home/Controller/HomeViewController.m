//
//  HomeViewController.m
//  XHongShu
//
//  Created by 周陆洲 on 16/5/24.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "HomeViewController.h"
//#import "MCWaterLayout.h"
#import "NotesCollectionCell.h"
#import "NotesDetailViewController.h"
#import "GoodsListModel.h"
#import "CollectionCellFrame.h"
#import "MCRefreshHeader.h"
#import "NavTransitioning.h"
#import "MCWaterFlowLayout.h"

static NSString * const NotesCollectionCellID = @"NotesCollectionCellID";

@interface HomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,MCWaterFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;
@property (nonatomic, strong) MCWaterFlowLayout *waterLayout;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *frameArray;

@property(strong, nonatomic) NavTransitioning *pushTransition;
@property(strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    _frameArray = [NSMutableArray array];
    [self initNavBar];
    
    [self getData];
}

- (void)initNavBar
{
    
    UIBarButtonItem *cameraBtn = [UIBarButtonItem itemWithImageName:@"btn_cam~iphone" target:self action:@selector(cameraBtnClick)];
    
    self.navigationItem.rightBarButtonItem = cameraBtn;
    
    [self createTitleView];
}

/**
 *  创建titleView
 */
- (void)createTitleView
{
    UIControl *titleControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
    [titleControl addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleControl;
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 60, 22)];
    logoView.image = [UIImage imageNamed:@"homeNavTitle"];
    [titleControl addSubview:logoView];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(63, 7, 11, 11)];
    arrowView.image = [UIImage imageNamed:@"xy_camera_icon_unfold~iphone"];
    [titleControl addSubview:arrowView];
    
}

- (void)backToRoot
{
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  获取数据源
 */
- (void)getData
{
    _dataArray = [NSMutableArray array];
    //封装请求参数
    
    [MCNetworkingLogin getLogin:homefeedUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [NSArray array];
        array = responseObject[@"data"];
        _dataArray = [GoodsListModel arrayOfModelsFromDictionaries:array];
        
        [self setFrameValues];
        [self initCollectionView];
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        self.collectionView.mj_header = [MCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [self.collectionView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

/**
 *  加载新数据
 */
-(void)loadNewData
{
    [MCNetworkingLogin getLogin:homefeedUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [_dataArray removeAllObjects];
        NSArray *array = [NSArray array];
        array = responseObject[@"data"];
        _dataArray = [GoodsListModel arrayOfModelsFromDictionaries:array];
        
        [self setFrameValues];
//        [self initCollectionView];
        
        [self.collectionView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.collectionView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)loadMoreData
{
    [MCNetworkingLogin getLogin:homefeedUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [NSArray array];
        array = responseObject[@"data"];
        array = [GoodsListModel arrayOfModelsFromDictionaries:array];
        [_dataArray addObjectsFromArray:array];
        
        [self setFrameValues];
//        [self initCollectionView];
        
        [self.collectionView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.collectionView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)setFrameValues
{
    for (GoodsListModel *model in _dataArray) {
        CollectionCellFrame *frameModel = [[CollectionCellFrame alloc] init];
        frameModel.goodsModel = model;
        [_frameArray addObject:frameModel];
    }
}

/**
 *  初始化CollectionView
 */
- (void)initCollectionView
{
    [self.view addSubview:self.collectionView];
    
    // 添加默认的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;
    footer.hidden = YES;
    
    // 设置footer
    self.collectionView.mj_footer = footer;
}

/**
 *  重写get
 */
-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:self.waterLayout];
        
        _collectionView.contentInset = UIEdgeInsetsZero;
        _collectionView.backgroundColor = MCColor(242, 246, 249, 1.0);
        [_collectionView registerNib:[UINib nibWithNibName:@"NotesCollectionCell" bundle:nil] forCellWithReuseIdentifier:NotesCollectionCellID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

-(MCWaterFlowLayout *)waterLayout
{
    if (_waterLayout == nil) {
        _waterLayout = [[MCWaterFlowLayout alloc]init];
        _waterLayout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    }
    return _waterLayout;
}
 
#pragma mark dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NotesCollectionCell *cell = [NotesCollectionCell cellWithCollectionView:collectionView indexPath:indexPath reuseIdentifier:NotesCollectionCellID];
    [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"++++++++++++++    %li",indexPath.row);
    cell.frameModel = _frameArray[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionCellFrame *model = [_frameArray objectAtIndex:indexPath.row];
    CGFloat itemH = model.itemSize.height;
    return CGSizeMake((SCREEN_WIDTH -30)/2,itemH);
}

#pragma mark delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NotesDetailViewController *ndVC = [[NotesDetailViewController alloc] init];
    
    GoodsListModel *model = [_dataArray objectAtIndex:indexPath.row];
    NSArray *array = [NSArray arrayWithArray:model.imagesList];
    ndVC.imgDic = array[0];
    ndVC.des = model.desc;
    ndVC.likes = model.likes;
    ndVC.favCount = model.favCount;
    
    [self.navigationController pushViewController:ndVC animated:YES];
}

-(NavTransitioning *)pushTransition
{
    if (!_pushTransition) {
        _pushTransition = [[NavTransitioning alloc] init];
    }
    
    return _pushTransition;
}

#pragma mark UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush && [toVC isKindOfClass:[NotesDetailViewController class]]) {
        return self.pushTransition;
    }else{
        return nil;
    }
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    self.navigationController.navigationBar.barTintColor = MainRedColor;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

/**
 *  titleView的点击响应
 */
-(void)titleClick
{
    NSLog(@"titleClick");
}

/**
 *  cameraBtn的点击响应
 */
-(void)cameraBtnClick
{
    NSLog(@"cameraBtnClick");
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
