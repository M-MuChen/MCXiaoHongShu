//
//  MeViewController.m
//  XHongShu
//
//  Created by 周陆洲 on 16/5/24.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MeViewController.h"
#import "FollowItem.h"
#import "TypeItem.h"
#import "AlbumView.h"
#import "AlbumTableViewCell.h"
#import "noteCollectionView.h"
#import "AllAlbumViewController.h"
#import "FollowTagsViewController.h"
#import "SelectPhotosViewController.h"
#import "FansViewController.h"
#import "SJButton.h"
#import "AddFriendsViewController.h"
#import <UIImageView+WebCache.h>
@interface MeViewController ()<selectPhonesDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView *_scrollView;
    UIView *userInfoView;
    UIView *myAlbumView;
    NSInteger flog;
    
    UIImageView *_potoImageView;
    UILabel *_userNameLabel;
    FollowItem *_peopleItem;
    FollowItem *_myFansItem;
    FollowItem *_tagsItem;
    FollowItem *_albumItem;
    
    SJButton *_titleBtn;
    
    UIImagePickerController *_imagePicker;
    
    UIView *_titleView;
    UIView *_titleMongoliaView;
}
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    [self getUserInfoData];
    if (5%3 == /* DISABLES CODE */ (0)) {
        flog = 5/3;
    }else{
        flog = 5/3+1;
    }
    [self barbtnItem];
    [self createUI];
}

- (void)initNavBar
{
    self.navigationController.navigationBar.barTintColor = MainWhriteColor;
    _titleBtn = [SJButton buttonWithType:UIButtonTypeSystem];
    _titleBtn.frame = CGRectMake(0, 0, 100, 32);
    //取消图片渲染效果
    UIImage *noSelectImg = [UIImage imageNamed:@"eventsale_sort_closed_default~iphone"];
    noSelectImg = [noSelectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectImg = [UIImage imageNamed:@"eventsale_sort_opened_default~iphone"];
    selectImg = [selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    _titleBtn.showsTouchWhenHighlighted = YES;
    [_titleBtn setImage:noSelectImg forState:UIControlStateNormal];
    [_titleBtn setImage:selectImg forState:UIControlStateSelected];
    [_titleBtn addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
    _titleBtn.adjustsImageWhenHighlighted = NO;

    self.navigationItem.titleView = _titleBtn;
    self.navigationItem.titleView.tintColor =  MainWhriteColor;
}

- (void)barbtnItem{
    UIBarButtonItem *userItem = [UIBarButtonItem itemWithImageName:@"xy_btn_invite~iphone" target:self action:@selector(searchUser)];
    self.navigationItem.leftBarButtonItem = userItem;
    
    UIBarButtonItem *setItem = [UIBarButtonItem itemWithImageName:@"xy_btn_setting~iphone" target:self action:@selector(set)];
    self.navigationItem.rightBarButtonItem = setItem;
}

/**
 *  获取用户信息数据
**/
- (void)getUserInfoData{

    [MCNetworkingLogin getLogin:userInfoUrlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = [NSDictionary dictionary];
        dict = responseObject[@"data"];
        _userInfoModel = [[MyMessageModel alloc] initWithDictionary:dict error:nil];
       [self setUserInfoValue];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        NSLog(@"%@",error);
    }];

}
- (void)createUI{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.backgroundColor = MCColor(242, 246, 249, 1.0);
    _scrollView.contentSize = CGSizeMake(0,  650 +flog*((SCREEN_WIDTH - 6)/3+3) + 64+ 49);
    [self.view addSubview:_scrollView];
    [self createUserInfoView];
    [self createMyAlbumView];
    [self createMyNotesView];
  
}

#pragma mark 创建用户信息
- (void)createUserInfoView{
    
    userInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, 260)];
    userInfoView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:userInfoView];
    
    _potoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((VIEW_WEDTH - 50)/2, 15,50,50)];
    _potoImageView.layer.cornerRadius = 25;
    _potoImageView.clipsToBounds = YES;
    _potoImageView.layer.masksToBounds = YES;
    [userInfoView addSubview:_potoImageView];
    
    _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_potoImageView.frame) + 12, VIEW_WEDTH, 15)];
    _userNameLabel.font = [UIFont systemFontOfSize:14];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    [userInfoView addSubview:_userNameLabel];
    
    CGFloat ControlBarWidth = VIEW_WEDTH/4;
    CGFloat ControlBarheight = 30;
    CGFloat ControlBarY =  CGRectGetMaxY(_userNameLabel.frame) + 27;
    CGSize barSize = CGSizeMake(ControlBarWidth, ControlBarheight);
    
    _peopleItem = [[FollowItem alloc]initWithName:@"关注的人" size:barSize];
    [_peopleItem setOrigin:CGPointMake(0, ControlBarY)];
    [_peopleItem addTarget:self action:@selector(followPeople) forControlEvents:UIControlEventTouchUpInside];
    [userInfoView addSubview:_peopleItem];
    
    _myFansItem = [[FollowItem alloc]initWithName:@"我的粉丝" size:barSize];
    [_myFansItem setOrigin:CGPointMake(ControlBarWidth, ControlBarY)];
    [_myFansItem addTarget:self action:@selector(myFans) forControlEvents:UIControlEventTouchUpInside];
    [userInfoView addSubview:_myFansItem];
    
    _tagsItem = [[FollowItem alloc]initWithName:@"关注的标签" size:barSize];
    [_tagsItem setOrigin:CGPointMake(ControlBarWidth*2, ControlBarY)];
    [_tagsItem addTarget:self action:@selector(followTags) forControlEvents:UIControlEventTouchUpInside];
    [userInfoView addSubview:_tagsItem];
    
    _albumItem = [[FollowItem alloc]initWithName:@"关注的专辑" size:barSize];
    [_albumItem setOrigin:CGPointMake(ControlBarWidth*3, ControlBarY)];
    [_albumItem addTarget:self action:@selector(followAlbum) forControlEvents:UIControlEventTouchUpInside];
    [userInfoView addSubview:_albumItem];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_peopleItem.frame)+15, VIEW_WEDTH, 1)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [userInfoView addSubview:lineView];
    
    CGFloat lineWidth = 1;
    CGFloat lineheight = 44;
    CGFloat lineY =  CGRectGetMaxY(lineView.frame) + 25;
    CGFloat lineMagin = (VIEW_WEDTH - lineWidth*3)/4;
    
    UIView *verticalLine1 = [[UIView alloc]initWithFrame:CGRectMake(lineMagin, lineY, lineWidth, lineheight)];
    verticalLine1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [userInfoView addSubview:verticalLine1];
    
    UIView *verticalLine2 = [[UIView alloc]initWithFrame:CGRectMake(lineMagin*2+lineWidth, lineY, lineWidth, lineheight)];
    verticalLine2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [userInfoView addSubview:verticalLine2];
    
    UIView *verticalLine3 = [[UIView alloc]initWithFrame:CGRectMake(lineMagin*3+lineWidth, lineY, lineWidth, lineheight)];
    verticalLine3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [userInfoView addSubview:verticalLine3];
    
    
    CGFloat itemWidth = 50;
    CGFloat itemheight = 64;
    CGFloat itemY =  CGRectGetMaxY(lineView.frame) + 15;
    CGFloat itemMagin = (VIEW_WEDTH - itemWidth*4)/8;
    
    TypeItem *shopCartItem = [[TypeItem alloc]initWithImage:@"xyvg_me_cart~iphone" title:@"购物车"];
    shopCartItem.frame = CGRectMake(itemMagin, itemY, itemWidth, itemheight);
    [shopCartItem addTarget:self action:@selector(shopCart) forControlEvents:UIControlEventTouchUpInside];
    [userInfoView addSubview:shopCartItem];
    
    TypeItem *orderItem = [[TypeItem alloc]initWithImage:@"xyvg_me_order~iphone" title:@"订单"];
    orderItem.frame = CGRectMake(itemMagin*3+itemWidth, itemY, itemWidth, itemheight);
    [orderItem addTarget:self action:@selector(order) forControlEvents:UIControlEventTouchUpInside];
    [userInfoView addSubview:orderItem];
    
    TypeItem *potatoCouponItem = [[TypeItem alloc]initWithImage:@"xyvg_me_coupon~iphone" title:@"薯劵"];
    potatoCouponItem.frame = CGRectMake(itemMagin*5+itemWidth*2, itemY, itemWidth, itemheight);
    [potatoCouponItem addTarget:self action:@selector(potatoCoupon) forControlEvents:UIControlEventTouchUpInside];
    [userInfoView addSubview:potatoCouponItem];
    
    TypeItem *wishListItem = [[TypeItem alloc]initWithImage:@"xyvg_me_wishlist~iphone" title:@"心愿单"];
    wishListItem.frame = CGRectMake(itemMagin*7+itemWidth*3, itemY, itemWidth, itemheight);
    [wishListItem addTarget:self action:@selector(wishList) forControlEvents:UIControlEventTouchUpInside];
    [userInfoView addSubview:wishListItem];
}
#pragma mark 创建我的专辑
- (void)createMyAlbumView{
    myAlbumView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(userInfoView.frame)+10, VIEW_WEDTH, ((SCREEN_WIDTH - 27)/2 +60)+78+20)];
    myAlbumView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:myAlbumView];
    
    UILabel *titleLabel =  [[UILabel alloc]initWithFrame:CGRectMake(12,0 , 100, 78)];
    titleLabel.text = [NSString stringWithFormat:@"我的专辑 · %@",@3];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [myAlbumView addSubview:titleLabel];
    
    UIButton *titleBtn =  [[UIButton alloc]initWithFrame:CGRectMake(VIEW_WEDTH - 100, 0 , 100, 78)];
    [titleBtn setTitle:@"查看所有>" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [titleBtn addTarget:self action:@selector(allAlbum) forControlEvents:UIControlEventTouchUpInside];
    [myAlbumView addSubview:titleBtn];
    
    AlbumView *albumView1 = [[AlbumView alloc]initWithFrame:CGRectMake(9, CGRectGetMaxY(titleLabel.frame),(SCREEN_WIDTH - 27)/2, (SCREEN_WIDTH - 27)/2 +60)];

    [myAlbumView addSubview:albumView1];
    
    AlbumView *albumView2 = [[AlbumView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(albumView1.frame)+9, CGRectGetMaxY(titleLabel.frame),(SCREEN_WIDTH - 27)/2, (SCREEN_WIDTH - 27)/2 +60)];
    [myAlbumView addSubview:albumView2];

}
#pragma mark 创建我的笔记
- (void)createMyNotesView{

    UIView *myNotesView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(myAlbumView.frame)+10, SCREEN_WIDTH, flog*((SCREEN_WIDTH - 6)/3+3)+78)];
    myNotesView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:myNotesView];
    NSLog(@"%ld",(long)flog);
    UILabel *titleLabel =  [[UILabel alloc]initWithFrame:CGRectMake(12, 0 , 100, 78)];
    titleLabel.text = [NSString stringWithFormat:@"我的笔记 · %@",@2];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [myNotesView addSubview:titleLabel];
    
    NoteCollectionView *noteView = [[NoteCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), SCREEN_WIDTH, flog*((SCREEN_WIDTH - 6)/3+3))];
    noteView.backgroundColor = [UIColor darkGrayColor];
    noteView.delegate = self;
    [myNotesView addSubview:noteView];

}
- (void)searchUser{
    AddFriendsViewController *addFriendsVC = [[AddFriendsViewController alloc]init];
    [self.navigationController pushViewController:addFriendsVC animated:YES];
}
- (void)set{

}
#pragma mark 购物车
- (void)shopCart{

}
#pragma mark 订单
- (void)order{
    
}
#pragma mark 薯劵
- (void)potatoCoupon{
    
}
#pragma mark 心愿单
- (void)wishList{
    
}
#pragma mark 关注的人
- (void)followPeople{

}
#pragma mark 我的粉丝
- (void)myFans{
    FansViewController *fansVC = [[FansViewController alloc]init];
    [self.navigationController pushViewController:fansVC animated:YES];
}
#pragma mark 关注的标签
- (void)followTags{
    FollowTagsViewController *followTagsVC = [[FollowTagsViewController alloc]init];
    [self.navigationController pushViewController:followTagsVC animated:YES];
}
#pragma mark 关注的专辑
- (void)followAlbum{
    
}
#pragma mark 所有专辑
- (void)allAlbum{
    AllAlbumViewController *allAlbumVC = [[AllAlbumViewController alloc]init];
    [self.navigationController pushViewController:allAlbumVC animated:YES];
}
#pragma mark 用户积分和信息
- (void)info:(SJButton*)btn{
    if (btn.isSelected) {
        _titleBtn.selected = NO;

        [UIView animateWithDuration:0.4 //动画时长
                              delay:0   //动画延时
             usingSpringWithDamping:0.8   //类似弹簧效果0~1f，数值越小「弹簧」的振动效果越明显
              initialSpringVelocity:0   //初始速度
                            options:0   //动画过滤效果
                         animations:^{
                             _titleView.frame = CGRectMake(0, 60, VIEW_WEDTH, 0);
                            _titleMongoliaView.alpha = 0;
                         } completion:^(BOOL finished) {
                             
                         }];

    }else{
         _titleBtn.selected = YES;
        if (!_titleView) {
            _titleMongoliaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, VIEW_HEIGHT -44)];
            _titleMongoliaView.alpha = 0;
            _titleMongoliaView.backgroundColor = [UIColor blackColor];
            [self.view addSubview:_titleMongoliaView];
            
            UITapGestureRecognizer *clearMongoliaGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearMongoliaView)];
            [_titleMongoliaView addGestureRecognizer:clearMongoliaGesture];
            
            _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, VIEW_WEDTH, 0)];
            _titleView.backgroundColor = [UIColor whiteColor];
            [self.view  addSubview:_titleView];
    
        }
    
        [UIView animateWithDuration:0.4 //动画时长
                              delay:0   //动画延时
             usingSpringWithDamping:0.8   //类似弹簧效果0~1f，数值越小「弹簧」的振动效果越明显
              initialSpringVelocity:0   //初始速度
                            options:0   //动画过滤效果
                         animations:^{
                             _titleView.frame = CGRectMake(0, 60, VIEW_WEDTH, 100);
                              _titleMongoliaView.alpha = 0.6;
                         } completion:^(BOOL finished) {
                             
                         }];
    }

    
}
- (void)setUserInfoValue{
    
    [_titleBtn setTitle:_userInfoModel.nickname forState:UIControlStateNormal];
//    _titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-_titleBtn.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
//    _titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, _titleBtn.imageView.bounds.size.width, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）

    [_potoImageView sd_setImageWithURL:[NSURL URLWithString: _userInfoModel.images]];
    _userNameLabel.text = _userInfoModel.nickname;
    _peopleItem.countLabel.text = [NSString stringWithFormat:@"%@",_userInfoModel.follows];
    _myFansItem.countLabel.text = [NSString stringWithFormat:@"%@",_userInfoModel.fans];
    _tagsItem.countLabel.text = [NSString stringWithFormat:@"%@",_userInfoModel.followingTags];
    _albumItem.countLabel.text = [NSString stringWithFormat:@"%@",_userInfoModel.followingBoards];
    

}
#pragma mark selectPhonesDelegate
-(void)selectPhones{

    SelectPhotosViewController *selectPhotosVC = [[SelectPhotosViewController alloc]init];
    selectPhotosVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:selectPhotosVC animated:YES];
//    [self createImagePicker];
    
}
//- (void)createImagePicker{
//    
//    _imagePicker = [[UIImagePickerController alloc]init];
//    _imagePicker.view.backgroundColor = [UIColor orangeColor];
//    _imagePicker.delegate = self;
//    _imagePicker.allowsEditing = YES;
//    _imagePicker.sourceType =UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    [self presentViewController:_imagePicker animated:YES completion:nil];
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary
//                                                                                               *)info{
//    NSString *const  UIImagePickerControllerMediaType ;//指定用户选择的媒体类型（文章最后进行扩展）
//    NSString *const  UIImagePickerControllerOriginalImage ;//原始图片
//    NSString *const  UIImagePickerControllerEditedImage ;//修改后的图片
//    NSString *const  UIImagePickerControllerCropRect ;//裁剪尺寸
//    NSString *const  UIImagePickerControllerMediaURL ;//媒体的URL
//    NSString *const  UIImagePickerControllerReferenceURL ;//原件的URL
//    NSString *const  UIImagePickerControllerMediaMetadata;//当来数据来源是照相机的时候这个值才有效
//    
////    _imageView.image = [UIImage imageNamed:UIImagePickerControllerCropRect];
////    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
- (void)clearMongoliaView{
    _titleBtn.selected = NO;
    
    [UIView animateWithDuration:0.4 //动画时长
                          delay:0   //动画延时
         usingSpringWithDamping:0.8   //类似弹簧效果0~1f，数值越小「弹簧」的振动效果越明显
          initialSpringVelocity:0   //初始速度
                        options:0   //动画过滤效果
                     animations:^{
                         _titleView.frame = CGRectMake(0, 0, VIEW_WEDTH, 0);
                         _titleMongoliaView.alpha = 0;
                     } completion:^(BOOL finished) {
                         
                     }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
