//
//  SelectPhotosViewController.m
//  XHongShu
//
//  Created by 宋江 on 16/6/3.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "SelectPhotosViewController.h"
#import "CollectionHeadView.h"
#import "SJButton.h"
#import "PotoTableView.h"
#import "SelectPotoViewCell.h"
#import "EditPotoViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "PasterController.h"
#import <UIImageView+WebCache.h>
static NSString *cellIdentifier = @"cell9";
static NSString *headerIdentifier = @"header";
@interface SelectPhotosViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate, UIImagePickerControllerDelegate,PotoTableViewDelegate>
{

    UIImageView *_imageView;
    UICollectionView *_potoCollectionView;
    UICollectionReusableView *_someHeaderView;
    
    UIImageView *_headImageView;

    AVCaptureSession * _AVSession;//调用闪光灯的时候创建的类
    
    SJButton *_titleBtn;
    PotoTableView *_potoView;
    
    UIView *_MongoliaLayer;
    
    NSMutableArray *_groupArray;
    NSMutableArray *_groupNameArray;
    

}
@property(nonatomic,strong)NSMutableArray *imageArray;

@property(nonatomic,strong)ALAssetsGroup *group;

@property(nonatomic,retain)AVCaptureSession * AVSession;

@property(nonatomic,strong)NSMutableArray *urlArray;
@end

@implementation SelectPhotosViewController

- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArray = [NSMutableArray array];
    _urlArray = [NSMutableArray array];
 
    [self initNavBar];
    [self barbtnItem];
    [self getImgs];

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
    [_titleBtn addTarget:self action:@selector(selectGroup:) forControlEvents:UIControlEventTouchUpInside];
    _titleBtn.adjustsImageWhenHighlighted = NO;
    
    [_titleBtn setTitle:@"所有照片" forState:UIControlStateNormal];
    self.navigationItem.titleView = _titleBtn;
    self.navigationItem.titleView.tintColor = MainWhriteColor;
    
}
//创建CollectionView
- (void)createCollectionView{
    
     UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

    _potoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, VIEW_WEDTH,VIEW_HEIGHT) collectionViewLayout:flowLayout];
    _potoCollectionView.backgroundColor = [UIColor whiteColor];
    _potoCollectionView.delegate = self;
    _potoCollectionView.dataSource = self;
//    _potoCollectionView.scrollEnabled = YES;
    [_potoCollectionView registerClass:[SelectPotoViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [_potoCollectionView registerClass:[CollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [self.view addSubview:_potoCollectionView];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectPotoViewCell *cell = [_potoCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
          cell.imageView.image = [UIImage imageNamed:@"post_album_camera~iphone"];
        
    }else{
          cell.imageView.image = _imageArray[indexPath.row];

    }
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count > 0?_imageArray.count:0;
//    return 100;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((VIEW_WEDTH - 16)/3, (VIEW_WEDTH - 16)/3);
}
- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(3, 3, 3, 3);
}
//collectionViewcell之间的高度
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(VIEW_WEDTH, VIEW_HEIGHT*0.6);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]) {
        CollectionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, VIEW_HEIGHT*0.6)];
        
        [self imageFromUrl:_urlArray[0]];
        
        [headerView addSubview:_headImageView];
        
        return headerView;
    }else{
        return nil;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        [self addCarema];
    }else{
        [self imageFromUrl:_urlArray[indexPath.row]];
   
    }
    
}
- (void)imageFromUrl:(NSString*)urlStr{
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    NSURL *url=[NSURL URLWithString:urlStr];
    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
        UIImage *image=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        _headImageView.image=image;
        
    }failureBlock:^(NSError *error) {
        NSLog(@"error=%@",error);
    }
     ];
}
+ (UIImage *)thumbnailFromALAsset:(ALAsset *)asset
{
    CGImageRef imgRef = asset.thumbnail;
    UIImage *img = [UIImage imageWithCGImage:imgRef];
    return img;
}

-(void)getImgs{
    _groupNameArray=[[NSMutableArray alloc]initWithObjects:@"所有照片", nil];
    _groupArray = [NSMutableArray array];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror){
            NSLog(@"相册访问失败 =%@", [myerror localizedDescription]);
            if ([myerror.localizedDescription rangeOfString:@"Global denied access"].location!=NSNotFound) {
                NSLog(@"无法访问相册.请在'设置->定位服务'设置为打开状态.");
            }else{
                NSLog(@"相册访问失败.");
            }
        };
        //
        ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result, NSUInteger index, BOOL *stop){
            if (result!=NULL) {
                
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    NSString *urlstr=[NSString stringWithFormat:@"%@",result.defaultRepresentation.url]; //图片的url
                    [_urlArray addObject:urlstr];
                    [_imageArray addObject:[SelectPhotosViewController thumbnailFromALAsset:result]];
                
                }
            }
            
        };
        
        //
        ALAssetsLibraryGroupsEnumerationResultsBlock
        libraryGroupsEnumeration = ^(ALAssetsGroup* group, BOOL* stop){
            NSLog(@"%i",*stop);
            if (group == nil)
            {
               [self createCollectionView];
                if (!_potoView) {
                    
                    for (int i = 0; i<_groupArray.count; i++) {
                        
                        NSString *g1=[_groupArray[i] substringFromIndex:16 ] ;
                        NSArray *arr=[[NSArray alloc] init];
                        arr=[g1 componentsSeparatedByString:@","];
                        NSString *g2=[[arr objectAtIndex:0] substringFromIndex:5];
                        if ([g2 isEqualToString:@"Camera Roll"]) {
                            g2=@"相机胶卷";
                        }
        
                        [_groupNameArray addObject: g2];//组的name
                    }
                    
                    _MongoliaLayer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, VIEW_HEIGHT)];
                    _MongoliaLayer.alpha = 0;
                    _MongoliaLayer.backgroundColor = [UIColor grayColor];
                    [self.view addSubview:_MongoliaLayer];
                                        
                    _potoView = [[PotoTableView alloc]initWithFrame:CGRectMake(0,44, VIEW_WEDTH, 0) style:UITableViewStyleGrouped];
                    _potoView.delegate1 = self;
                    _potoView.dataArray = _groupNameArray;
                    _potoView.groupArray =  _groupArray;
                    [_MongoliaLayer addSubview:_potoView];
                    
                }

            }
            
            if (group!=nil) {
                NSString *g=[NSString stringWithFormat:@"%@",group];//获取相簿的组
                NSLog(@"gg:%@",g);//gg:ALAssetsGroup - Name:Camera Roll, Type:Saved Photos, Assets count:71
//
//                NSString *g1=[g substringFromIndex:16 ] ;
//                NSArray *arr=[[NSArray alloc] init];
//                arr=[g1 componentsSeparatedByString:@","];
//                NSString *g2=[[arr objectAtIndex:0] substringFromIndex:5];
//                if ([g2 isEqualToString:@"Camera Roll"]) {
//                    g2=@"相机胶卷";
//                }
//
//                NSString *groupName=g2;//组的name
                [_groupArray addObject:g];
                
                [group enumerateAssetsUsingBlock:groupEnumerAtion];
            }
            
        };
        
        ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
        [library enumerateGroupsWithTypes:ALAssetsGroupAll
                               usingBlock:libraryGroupsEnumeration
                             failureBlock:failureblock];
    }); 
    
}

-(void)filterImageWithGroup:(ALAssetsGroup *)group
{
    [_imageArray removeAllObjects];
//    ALAssetsGroupEnumerationResultsBlock groupEnumerAtion1 = ^(ALAsset *result, NSUInteger index, BOOL *stop)
//    {
//        NSLog(@"-===-----=--=-==-   %@",[SelectPhotosViewController fullResolutionImageFromALAsset:result]);
//        if (result!=NULL)
//        {
//            if ([[result valueForProperty:ALAssetPropertyType]isEqualToString:ALAssetTypePhoto])
//            {
//                [_imageArray addObject:[SelectPhotosViewController fullResolutionImageFromALAsset:result]];
//                 [_potoCollectionView reloadData];
//            }
//        }
//        else
//        {
//           
//        }
//        
//    };
//    [group enumerateAssetsUsingBlock:groupEnumerAtion1];
    
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result!=NULL)
        {
            if ([[result valueForProperty:ALAssetPropertyType]isEqualToString:ALAssetTypePhoto])
            {
                [_imageArray addObject:[SelectPhotosViewController thumbnailFromALAsset:result]];
                [_potoCollectionView reloadData];
            }
        }
        else
        {
            
        }
    }];
}
//打开相机
-(void)addCarema
{
    //判断是否可以打开相机，模拟器此功能无法使用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;  //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];

    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Are you 明白!" otherButtonTitles:nil];
        [alert show];
    }
}
//拍摄完成后要执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //得到图片
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //图片存入相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//点击Cancel按钮后执行方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
      [self dismissViewControllerAnimated:YES completion:nil];
}
//
-(void)openPicLibrary
{
    //相册是可以用模拟器打开的
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;//是否可以编辑
        
        //打开相册选择照片
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
    }
    
}

//选中图片进入的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)barbtnItem{
    UIBarButtonItem *userItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain  target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = userItem;
    
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc]initWithTitle:@"继续" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
 
    self.navigationItem.rightBarButtonItem = setItem;
}
//调用闪关灯
-(void)openFlashlight
{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.torchMode == AVCaptureTorchModeOff) {
        //Create an AV session
        AVCaptureSession * session = [[AVCaptureSession alloc]init];
        
        // Create device input and add to current session
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        [session addInput:input];
        
        // Create video output and add to current session
        AVCaptureVideoDataOutput * output = [[AVCaptureVideoDataOutput alloc]init];
        [session addOutput:output];
        
        // Start session configuration
        [session beginConfiguration];
        [device lockForConfiguration:nil];
        
        // Set torch to on
        [device setTorchMode:AVCaptureTorchModeOn];
        
        [device unlockForConfiguration];
        [session commitConfiguration];
        
        // Start the session
        [session startRunning];
        
        // Keep the session around
        [self setAVSession:self.AVSession];

    }
}

-(void)closeFlashlight
{
    [self.AVSession stopRunning];
}
#pragma mark 取消
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 继续
- (void)next{
    PasterController *pasterVC = [[PasterController alloc]init];
    pasterVC.imageWillHandle = _headImageView.image;
    [self.navigationController pushViewController:pasterVC animated:YES];
}
#pragma mark 选组
- (void)selectGroup:(SJButton *)btn{

    if (btn.isSelected) {
        _titleBtn.selected = NO;
        [UIView animateWithDuration:0.4 animations:^{
            _potoView.frame = CGRectMake(0, 44, VIEW_WEDTH, 0);
            _MongoliaLayer.alpha = 0;
        }];
    }else{
        _titleBtn.selected = YES;

        [UIView animateWithDuration:0.4 animations:^{
            _potoView.frame = CGRectMake(0, 44, VIEW_WEDTH, 400);
            _MongoliaLayer.alpha = 0.9;
        }];
    }

}
#pragma mark 关闭蒙层
- (void)mongoliaCancel{
    
    _titleBtn.selected = NO;
    [UIView animateWithDuration:0.4 animations:^{
        _potoView.frame = CGRectMake(0, 44, VIEW_WEDTH, 0);
        _MongoliaLayer.alpha = 0;
    }];
}
- (void)titleViewName:(NSString *)name groupName:(ALAssetsGroup *)groupName{
    
    _titleBtn.selected = NO;
    [_titleBtn setTitle:name forState:UIControlStateNormal];
    [UIView animateWithDuration:0.4 animations:^{
        _potoView.frame = CGRectMake(0, 44, VIEW_WEDTH, 0);
        _MongoliaLayer.alpha = 0;
    }];
    if (groupName == nil) {
//        [self allpoto];
    }else{
        [self filterImageWithGroup:groupName];
    }

}
#warning mark 获取全部照片  还是有问题

- (void)allpoto{
    [_imageArray removeAllObjects];
    ALAssetsGroupEnumerationResultsBlock groupEnumerAtion2 = ^(ALAsset *result, NSUInteger index, BOOL *stop){
        if (result!=NULL) {
            
            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                [_imageArray addObject:[SelectPhotosViewController thumbnailFromALAsset:result]];
                [_potoCollectionView reloadData];
            }
        }
        
    };
    ALAssetsLibraryGroupsEnumerationResultsBlock
    libraryGroupsEnumeration = ^(ALAssetsGroup* group, BOOL* stop){
        
    [group enumerateAssetsUsingBlock:groupEnumerAtion2];
        
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:libraryGroupsEnumeration
                         failureBlock:nil];
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
