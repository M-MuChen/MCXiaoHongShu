//
//  BuyViewController.m
//  XHongShu
//
//  Created by 周陆洲 on 16/5/24.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BuyViewController.h"
#import "CategoryModel.h"
#import "SXTitleLable.h"
#import "UIView+Frame.h"
#import "MJExtension.h"
#import "ItemCollectionView.h"
#import "BuyCollectionViewController.h"
@interface BuyViewController ()<UIScrollViewDelegate,changeItemDelegate>

/** 标题栏 */
@property (strong, nonatomic)UIScrollView *smallScrollView;
/** 下面的内容栏 */
@property (strong, nonatomic)UIScrollView *bigScrollView;
@property(nonatomic,strong) NSMutableArray *arrayLists;
@property (nonatomic,strong)CategoryModel *categoryModel;
@property (strong, nonatomic)UIButton *selectItemBtn;
@property (strong, nonatomic)UIView *bgItemView;
@property (strong, nonatomic)UIView *bgView;  //蒙层

@property (nonatomic,assign)CGFloat smainW;

@property (strong, nonatomic)ItemCollectionView *itemCollectionView;
@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
    [self barbtnItem];
    [self getItemData];

}

- (void)initNavBar
{
    self.navigationItem.title = @"福利社";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.barTintColor = MainRedColor;
    
}
- (void)barbtnItem{
    UIBarButtonItem *goShopItem = [UIBarButtonItem itemWithImageName:@"store_cart~iphone" target:self action:@selector(goShop)];
    
    self.navigationItem.rightBarButtonItem = goShopItem;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)getItemData{
    _arrayLists = [NSMutableArray array];
    [MCNetworkingLogin getLogin:buyItemString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *itemArray = responseObject[@"data"];
        _arrayLists = [NSMutableArray  arrayWithArray:itemArray];
        [self createUI];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

- (void)createUI{
    UIButton *noSelectItemBtn = [[UIButton alloc]initWithFrame:CGRectMake(VIEW_WEDTH - 40, 64, 40, 40)];
    [noSelectItemBtn setImage:[UIImage imageNamed:@"goods_category_indicator_open~iphone"] forState:UIControlStateNormal];
    [noSelectItemBtn addTarget:self action:@selector(noSelectItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noSelectItemBtn];
    
    self.smallScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WEDTH -40, 40)];
    [self.view addSubview:_smallScrollView];
    
    self.bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 105, VIEW_WEDTH, VIEW_HEIGHT - 153)];
    [self.view addSubview:_bigScrollView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    self.smallScrollView.showsVerticalScrollIndicator = NO;
    self.bigScrollView.delegate = self;
    
    [self addController];
    [self addLable];
    
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScrollView.contentSize = CGSizeMake(contentX, 0);
    self.bigScrollView.pagingEnabled = YES;
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:vc.view];
    SXTitleLable *lable = [self.smallScrollView.subviews firstObject];
    lable.scale = 1.0;
    self.bigScrollView.showsHorizontalScrollIndicator = NO;
   
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SXAdvertisementKey" object:nil];
}


#pragma mark - ******************** 添加方法

/** 添加子控制器 */
- (void)addController
{
    for (int i=0 ; i<self.arrayLists.count ;i++){
       _categoryModel = [[CategoryModel alloc]initWithDictionary:_arrayLists[i] error:nil];

        BuyCollectionViewController *vc1 = [[BuyCollectionViewController alloc]init];
        vc1.title = _categoryModel.name;
   
        [self addChildViewController:vc1];
    }
}

/** 添加标题栏 */
- (void)addLable
{
    _smainW = 5.0f;
    for (int i = 0; i < _arrayLists.count; i++) {
        CategoryModel * categoryModel = [[CategoryModel alloc]initWithDictionary:_arrayLists[i] error:nil];
        
        CGSize lblSize = [categoryModel.name sizeWithFont:MCFont(19) lineSpacing:0 maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGFloat lblY = 0;
        CGFloat lblX = _smainW;
        _smainW +=lblSize.width;

        SXTitleLable *lbl1 = [[SXTitleLable alloc]init];
        UIViewController *vc = self.childViewControllers[i];
        lbl1.text =vc.title;
        lbl1.frame = CGRectMake(lblX, lblY, lblSize.width, 40);
        lbl1.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [self.smallScrollView addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    self.smallScrollView.contentSize = CGSizeMake(_smainW , 0);
    
}

/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    SXTitleLable *titlelable = (SXTitleLable *)recognizer.view;
    
    CGFloat offsetX = titlelable.tag * self.bigScrollView.frame.size.width;
    
    CGFloat offsetY = self.bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bigScrollView setContentOffset:offset animated:YES];
    
    
}

#pragma mark - ******************** scrollView代理方法

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;

    // 滚动标题栏
    SXTitleLable *titleLable = (SXTitleLable *)self.smallScrollView.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - self.smallScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.smallScrollView.contentOffset.y);
    [self.smallScrollView setContentOffset:offset animated:YES];
    // 添加控制器
    BuyCollectionViewController *newsVc = self.childViewControllers[index];
//    newsVc.indexs = index;
    
    [self.smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            SXTitleLable *temlabel = self.smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:newsVc.view];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    SXTitleLable *labelLeft = self.smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.smallScrollView.subviews.count) {
        SXTitleLable *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    
}
- (void)noSelectItem:(UIButton *)btn{
  [self createItemView];
}
- (void)selectItem:(UIButton *)btn{
    
    [UIView animateWithDuration:0.3 animations:^{
        _itemCollectionView.frame = CGRectMake(0,-75, VIEW_WEDTH, 120);
    } completion:^(BOOL finished) {
        _bgView.hidden = YES;
        _bgItemView.hidden  = YES;
    }];
    
}
- (void)createItemView{

    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WEDTH, VIEW_HEIGHT - 64)];
        _bgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
        [self.view addSubview:_bgView];

        _itemCollectionView = [[ItemCollectionView alloc]initWithFrame:CGRectMake(0,-16, VIEW_WEDTH, 120)];
        NSArray *itemArray  = [CategoryModel arrayOfModelsFromDictionaries:_arrayLists];
        _itemCollectionView.dataArray = itemArray;
        _itemCollectionView.itemDelegate = self;
        [_bgView addSubview:_itemCollectionView];
        
        [UIView animateWithDuration:0.3 animations:^{
            _itemCollectionView.frame = CGRectMake(0, 40, VIEW_WEDTH, 120);
        }];
        
        _bgItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, 40)];
        _bgItemView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_bgView addSubview:_bgItemView];
        
        UILabel *allLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, VIEW_WEDTH - 40, 40)];
        allLabel.text = @"全部分类";
        allLabel.textColor = [UIColor grayColor];
        allLabel.font = [UIFont systemFontOfSize:13];
        [_bgItemView addSubview:allLabel];
        
        UIButton *selectItemBtn = [[UIButton alloc]initWithFrame:CGRectMake(VIEW_WEDTH - 40, 0, 40, 40)];
        [selectItemBtn setImage:[UIImage imageNamed:@"goods_category_indicator_close~iphone"] forState:UIControlStateNormal];
        [selectItemBtn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [_bgItemView addSubview:selectItemBtn];

    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _itemCollectionView.frame = CGRectMake(0,  CGRectGetMaxY(_bgItemView.frame), VIEW_WEDTH, 120);
        }];
        _bgView.hidden = NO;
        _bgItemView.hidden  = NO;
    
    }


}
- (void)changeItem:(NSInteger)integer{
    
    _bgView.hidden = YES;
    _bgItemView.hidden  = YES;
    CGFloat offsetX = integer * self.bigScrollView.frame.size.width;
    
    CGFloat offsetY = self.bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bigScrollView setContentOffset:offset animated:YES];
    
}
#pragma mark 我的购物车
- (void)goShop{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
