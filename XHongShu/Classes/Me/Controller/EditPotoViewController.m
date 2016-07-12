//
//  EditPotoViewController.m
//  XHongShu
//
//  Created by 宋江 on 16/6/8.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "EditPotoViewController.h"
#import "EditPotoView.h"
#import "NavigationView.h"
#import "SelectLabelViewController.h"
#import "XHTagView.h"
#import "EditPotoModel.h"
#import "EditPotoCollectionView.h"

typedef enum {
    Navigation_Filter = 0,
    Navigation_Sticker,
    
}type;
@interface EditPotoViewController ()<UITextFieldDelegate>
{
    NavigationView *_navigationView;
    UIImageView *_potoImageView;
    UIView *_addLabelView;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_muArray;
    
    NSArray *_filterGalleryArray;
    NSArray *_beautifyPhotosArray;
    NSArray *_activityStickersArray;
    NSArray *_myStickerArray;
    
    NSDictionary *_dict;
    
    CGPoint _point;//点击屏幕的哪个点
    
    EditPotoModel  *_editPotoModel;
    
    
}
@property (nonatomic,strong)XHTagView *tagView;

@property (nonatomic,strong)UIButton *stickerBtn1;
@property (nonatomic,strong)UIButton *stickerBtn2;

@property (nonatomic,strong)UIButton *filterBtn1;
@property (nonatomic,strong)UIButton *filterBtn2;

@property (nonatomic,strong)EditPotoCollectionView *activityStickersView;
@property (nonatomic,strong)EditPotoCollectionView *myStickerView;
@property (nonatomic,strong)EditPotoCollectionView *filterGalleryView;

@property (nonatomic,strong)UIView *beautifyPhotosView;
@end

@implementation EditPotoViewController
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _filterGalleryArray = [NSArray arrayWithObjects:@"原图",@"迷失东京",@"挪威的森林",@"一页台北",@"罗马假日",@"恋战冲绳",@"情迷翡冷翠",@"布拉格之恋",@"旺角卡门",@"广岛之恋",@"冰岛之梦", nil];
    
    _beautifyPhotosArray = [NSArray arrayWithObjects:@"裁剪",@"亮度",@"对比度",@"色温",@"饱和度", nil];
    
    _activityStickersArray = [NSArray arrayWithObjects:@"不漏退等什么",@"欧洲杯看球必备",@"良心美剧我推荐",@"小长假去哪儿",@"这就是我的态度",@"爱美的态度",@"爱美的态度",@"爱美的态度",@"爱美的态度",@"吃货的态度",@"吃货的态度",@"吃货的态度",@"周末宅家",@"我心中的米其林",@"今夏必Buy连...",@"一线鞋星",@"小众控的好品味",@"夏日缤纷妆容色",@"周末探店",@"我的66第一单",@"历史贴纸", nil];

    _myStickerArray = [NSArray arrayWithObjects:@"不漏退等什么",@"欧洲杯看球必备",@"良心美剧我推荐",@"LOVE",@"BAG",@"Sweetheart",@"CrystalClear",@"GreatGift",@"Daisy",@"Rose", nil];
    
//    _dict =@{@"filterGallery":_filterGalleryArray,@"beautifyPhotos":_beautifyPhotosArray,@"activityStickers":_activityStickersArray,@"mySticker":_myStickerArray};
    
   _editPotoModel = [[EditPotoModel alloc]initWithDictionary:_dict error:nil];
    
    _dataArray = [NSMutableArray arrayWithObjects:@"品牌",@"名称",@"币种",@"价格",@"国家/城市",@"具体地点",nil];
    _muArray = [NSMutableArray array];
    [self initNavBar];
    [self barbtnItem];
    [self createUI];
//    
//    EditPhotosView *editPhotosView = [[EditPhotosView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self.view addSubview:editPhotosView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initNavBar{
    self.navigationController.navigationBar.barTintColor = MainWhriteColor;
    self.navigationItem.title = @"编辑照片(1/1)";
}

- (void)barbtnItem{
    UIBarButtonItem *userItem = [UIBarButtonItem itemWithImageName:@"navi_back~iphone" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = userItem;
    
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc]initWithTitle:@"继续" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
 
    self.navigationItem.rightBarButtonItem = setItem;
}
- (void)createUI{
    
    
    _potoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,44, SCREEN_WIDTH,SCREEN_HEIGHT *0.6)];
    _potoImageView.image = [UIImage imageNamed:@"user"];
    _potoImageView.userInteractionEnabled = YES;
    [self.view addSubview:_potoImageView];
    
    UITapGestureRecognizer *potoRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [_potoImageView addGestureRecognizer:potoRecognizer];

    _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_potoImageView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(_potoImageView.frame)) name:@[@"滤镜",@"标签",@"贴纸"]];
    _navigationView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_navigationView];
    
    [self createLabelView];
    [self createFilterView];
    [self creeateStickerView];
    
}
#pragma mark 标签
- (void)createLabelView{
    
    UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _navigationView.bounds.size.height -44)];
    labelView.backgroundColor = [UIColor whiteColor];
    [_navigationView.scrollView addSubview:labelView];
    
    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _navigationView.bounds.size.height - 44)];
    labelName.text = @"点击照片\n选择添加相关信息";
    labelName.font = [UIFont systemFontOfSize:16];
    labelName.textAlignment = NSTextAlignmentCenter;
    labelName.numberOfLines = 2;
    [labelView addSubview:labelName];
}
#pragma mark 滤镜
- (void)createFilterView{
//    EditPotoView *filterView = [[EditPotoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _navigationView.bounds.size.height -44) nameArray:@[@"滤镜库",@"美化照片"]];
//    filterView.backgroundColor = [UIColor whiteColor];
//    filterView.type = Navigation_Filter;
//    filterView.tag = 3000;
//    filterView.beautifyPhotosArray = _beautifyPhotosArray;
//    filterView.filterGalleryArray = _filterGalleryArray;
//    [_navigationView.scrollView addSubview:filterView];
    
    UIView *filterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH,  _navigationView.bounds.size.height -44)];
    [_navigationView.scrollView addSubview:filterView];
    
    _filterBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 60, 20)];
    _filterBtn1.tag = 3000;
    _filterBtn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [_filterBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_filterBtn1 setTitle:@"滤镜库" forState:UIControlStateNormal];
    
    [_filterBtn1 addTarget:self action:@selector(filterClick:) forControlEvents:UIControlEventTouchUpInside];
    [filterView addSubview:_filterBtn1];
    
    UIView *lineView = [ToolMothod createLineWithWidth:1.0 andHeight:20 andColor:[UIColor groupTableViewBackgroundColor]];
    lineView.frame = CGRectMake(CGRectGetMaxX(_filterBtn1.frame)+5, 10, 1.0, 20);
    [filterView addSubview:lineView];
    
    _filterBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame)+5, 10, 60, 20)];
    _filterBtn2.tag = 3001;
    _filterBtn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [_filterBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_filterBtn2 setTitle:@"美化照片" forState:UIControlStateNormal];
    [_filterBtn2 addTarget:self action:@selector(filterClick:) forControlEvents:UIControlEventTouchUpInside];
    [filterView addSubview:_filterBtn2];
    
    _filterGalleryView = [[EditPotoCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_stickerBtn1.frame)+10, VIEW_WEDTH,filterView.bounds.size.height -30)];
    _filterGalleryView.dataArray = _filterGalleryArray;
    _filterGalleryView.hidden = NO;
    [filterView addSubview:_filterGalleryView];
    
    _beautifyPhotosView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_stickerBtn1.frame), VIEW_WEDTH,filterView.bounds.size.height -30)];
    _beautifyPhotosView.hidden = YES;
    [filterView addSubview:_beautifyPhotosView];

    
}
#pragma mark 贴纸
- (void)creeateStickerView{
    
    UIView *stickerView = [[UIView alloc]initWithFrame:CGRectMake(VIEW_WEDTH*2, 0, VIEW_WEDTH,  _navigationView.bounds.size.height -44)];
    [_navigationView.scrollView addSubview:stickerView];
    
    _stickerBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 60, 20)];
    _stickerBtn1.tag = 2000;
    _stickerBtn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [_stickerBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_stickerBtn1 setTitle:@"活动贴纸" forState:UIControlStateNormal];
    
    [_stickerBtn1 addTarget:self action:@selector(stickerClick:) forControlEvents:UIControlEventTouchUpInside];
    [stickerView addSubview:_stickerBtn1];
    
    UIView *lineView = [ToolMothod createLineWithWidth:1.0 andHeight:20 andColor:[UIColor groupTableViewBackgroundColor]];
    lineView.frame = CGRectMake(CGRectGetMaxX(_stickerBtn1.frame)+5, 10, 1.0, 20);
    [stickerView addSubview:lineView];
    
    _stickerBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame)+5, 10, 60, 20)];
    _stickerBtn2.tag = 2001;
    _stickerBtn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [_stickerBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_stickerBtn2 setTitle:@"我的贴纸" forState:UIControlStateNormal];
    [_stickerBtn2 addTarget:self action:@selector(stickerClick:) forControlEvents:UIControlEventTouchUpInside];
    [stickerView addSubview:_stickerBtn2];
    
    _activityStickersView = [[EditPotoCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_stickerBtn1.frame)+10, VIEW_WEDTH,stickerView.bounds.size.height -30)];
    _activityStickersView.dataArray = _activityStickersArray;
    _activityStickersView.hidden = NO;
    [stickerView addSubview:_activityStickersView];
    
    _myStickerView = [[EditPotoCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_stickerBtn1.frame)+10, VIEW_WEDTH,stickerView.bounds.size.height -30)];
    _myStickerView.hidden = YES;
    _myStickerView.dataArray = _myStickerArray;
    [stickerView addSubview:_myStickerView];
    
//    
//    EditPotoView *stickerView = [[EditPotoView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, _navigationView.bounds.size.height -44) nameArray: @[@"活动贴纸",@"我的贴纸"]];
//    stickerView.backgroundColor = [UIColor whiteColor];
//    stickerView.type = Navigation_Sticker;
//    stickerView.tag = 3001;
//    stickerView.myStickerArray = _myStickerArray;
//    stickerView.activityStickersArray = _activityStickersArray;
//    stickerView.editPotoModel =  _editPotoModel;
//    [_navigationView.scrollView addSubview:stickerView];

}
#pragma mark 添加标签
- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)gesture{
    
    
    _point = [gesture locationInView:gesture.view];

    _tagView = [[XHTagView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _tagView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [_potoImageView addSubview:_tagView];

    _addLabelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _addLabelView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.9];
    [self.navigationController.view addSubview:_addLabelView];
    
     _addLabelView.alpha = 1.0;
    
    CGFloat field_Magin = 8;
    CGFloat field_HEIGHT = 30;
    CGFloat field_WEDTH = (VIEW_WEDTH - 5*field_Magin)/3;
    CGFloat field_X;
    CGFloat field_Y;
    for (int i = 0; i< 6; i++) {

        field_Y = i/2 * (field_HEIGHT +15) + 200 + 20;
        field_X = i%2*(field_WEDTH +field_Magin) +field_Magin*2;
        field_WEDTH = i%2*(VIEW_WEDTH - 5*field_Magin)/3+(VIEW_WEDTH - 5*field_Magin)/3;
        

        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(field_X, field_Y, field_WEDTH, 30)];
        
        textField.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        textField.clearButtonMode =  YES;
        textField.delegate = self;
        textField.leftViewMode = UITextFieldViewModeUnlessEditing;
        textField.tag = i;
        textField.textColor = [UIColor whiteColor];
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = MCColor(191, 193, 194, 1.0).CGColor;
        textField.layer.cornerRadius = 15;
        textField.font = [UIFont systemFontOfSize:12];
//        [textField addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [textField setText:[NSString stringWithFormat:@"    %@",_dataArray[i]]];
//        [textField setPlaceholder:[NSString stringWithFormat:@"    %@",_dataArray[i]]];
        [_addLabelView addSubview:textField];
        [_muArray addObject:textField];

    }

    UIButton *finishBtn = [[UIButton alloc]initWithFrame:CGRectMake((VIEW_WEDTH - 200)/2,400, 200, 30)];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishBtn.backgroundColor = [UIColor redColor];
    finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    finishBtn.layer.cornerRadius = 15;
    [finishBtn addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [_addLabelView addSubview:finishBtn];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake((VIEW_WEDTH - 200)/2, 450, 200, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor redColor];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cancelBtn.layer.cornerRadius = 15;
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [_addLabelView addSubview:cancelBtn];
    
    
}
#pragma mark 贴纸item
- (void)stickerClick:(UIButton *)btn{
    if (btn.tag == 2000) {
        _activityStickersView.hidden = NO;
        _myStickerView.hidden = YES;
    }else{
        _activityStickersView.hidden = YES;
        _myStickerView.hidden = NO;
    }
}
#pragma mark 滤镜item
- (void)filterClick:(UIButton *)btn{
    if (btn.tag == 3000) {
        _filterGalleryView.hidden = NO;
        _beautifyPhotosView.hidden = YES;
    }else{
        _filterGalleryView.hidden = YES;
        _beautifyPhotosView.hidden = NO;
    }
}
- (void)finish:(UIButton *)btn{
 
    _tagView.branchTexts = @[@"你要你要你要去去",@"仅仅看到",@"是大大说的"];
    [_tagView showInPoint:_point];
    _tagView.imageSize = CGSizeMake(_potoImageView.size.width, _potoImageView.size.height);
    _addLabelView.alpha = 0.0;
}
- (void)cancel:(UIButton *)btn{
    [UIView animateWithDuration:0.2 animations:^{
          _addLabelView.alpha = 0.0;
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //写你要实现的：页面跳转的相关代码
        if (textField == [_muArray objectAtIndex:3]) {
            [textField resignFirstResponder];
            return YES;
        }else{
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.3;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;
            [self.view.window.layer addAnimation:animation forKey:nil];
            
            SelectLabelViewController *selectLabelVC = [[SelectLabelViewController alloc]init];
            selectLabelVC.index = textField.tag;
            selectLabelVC.valueBlock = ^(NSString *value){
            
              [textField setText:[NSString stringWithFormat:@"    %@",value]];
            };
            [self presentViewController:selectLabelVC animated:NO completion:nil];

            return NO;

        }
}

- (void)drawPlaceholderInRect:(CGRect)rect{
    
    [[UIColor whiteColor] setFill];
    
}
#pragma mark 取消
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 继续
- (void)next{

}

@end
