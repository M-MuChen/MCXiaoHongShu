//
//  MCScrollView.m
//  XHongShu
//
//  Created by 周陆洲 on 16/6/12.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MCScrollView.h"
#import "UIImageView+AFNetworking.h"
#import <UIImageView+WebCache.h>
#import "ImagesList.h"
#import "XHTagView.h"

#define UISCREENWIDTH  self.bounds.size.width   //图片的宽度
#define UISCREENHEIGHT  self.bounds.size.height //图片的高度

#define HIGHT self.bounds.origin.y //由于_pageControl是添加进父视图的,所以实际位置要参考,滚动视图的y坐标

static NSUInteger currentImage;//记录中间图片的下标
static BOOL flag = YES;

@interface MCScrollView()
{
    //基本的三个视图
    UIImageView * _leftImageView;
    UIImageView * _centerImageView;
    UIImageView * _rightImageView;
    
    NSMutableArray *_imageWidthArray;
    NSMutableArray *_imageHeightArray;
    NSArray *_tagPageArray;
    
    CGFloat _scrollContentW;
    CGFloat _leftScrollH;
    CGFloat _centerScrollH;
    CGFloat _rightScrollH;
    CGFloat _currentOffSet;
    CGPoint _origin;
    
    NSUInteger realImage;
    
    BOOL isFirst;
}

@property (retain,nonatomic,readonly) UIImageView * leftImageView;
@property (retain,nonatomic,readonly) UIImageView * centerImageView;
@property (retain,nonatomic,readonly) UIImageView * rightImageView;

@end

@implementation MCScrollView

#pragma mark - 自由指定广告所占的frame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
//        self.contentOffset = CGPointMake(UISCREENWIDTH, 0);
        self.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        self.delegate = self;
        
        _origin = self.origin;
        
        _currentOffSet = 0;
        
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_leftImageView];
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_centerImageView];
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH*2, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [self addSubview:_rightImageView];
        
    }
    return self;
}

/**
 *  重写set
 */
-(void)setImageItemArray:(NSArray *)imageItemArray{
    if (_imageItemArray == nil) {
        _imageItemArray = [NSArray array];
    }
    _imageItemArray = imageItemArray;
    
    _imageWidthArray = [NSMutableArray array];
    _imageHeightArray = [NSMutableArray array];
    _imageNameArray = [NSMutableArray array];
    
    for (NSDictionary *dic in _imageItemArray) {
        ImagesList *imageModel = [[ImagesList alloc]initWithDictionary:dic error:nil];
        _scrollContentW += [imageModel.width floatValue];
        
        [_imageNameArray addObject:imageModel.url];
        [_imageWidthArray addObject:imageModel.width];
        [_imageHeightArray addObject:imageModel.height];
    }
    
    realImage = currentImage = 0;
    [self getImageFirst];
    
}

-(void)setTagArray:(NSArray *)tagArray
{
    if (_tagArray == nil) {
        _tagArray = [NSArray array];
    }
    _tagArray = tagArray;
}


-(void)getImageData
{
    
    _leftScrollH = [self getImageHWithImgW:_imageWidthArray[(currentImage-1)%_imageNameArray.count] imgH:_imageHeightArray[(currentImage-1)%_imageNameArray.count]];
    
    _centerScrollH = [self getImageHWithImgW:_imageWidthArray[currentImage%_imageNameArray.count] imgH:_imageHeightArray[currentImage%_imageNameArray.count]];
    
    _rightScrollH = [self getImageHWithImgW:_imageWidthArray[(currentImage+1)%_imageNameArray.count] imgH:_imageHeightArray[(currentImage+1)%_imageNameArray.count]];
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[(currentImage-1)%_imageNameArray.count]]];
    
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[currentImage%_imageNameArray.count]]];
    
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[(currentImage+1)%_imageNameArray.count]]];
}

-(void)getImageFirst{
//    XHTagView *tagView = [[XHTagView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    tagView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
//    [_leftImageView addSubview:tagView];
    
    _centerScrollH = [self getImageHWithImgW:_imageWidthArray[0] imgH:_imageHeightArray[0]];
    
    _rightScrollH = [self getImageHWithImgW:_imageWidthArray[1] imgH:_imageHeightArray[1]];
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[0]]];
    
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[1]]];
    
    currentImage = 1;
}

-(void)getImageLast{
    _centerScrollH = [self getImageHWithImgW:_imageWidthArray[_imageNameArray.count-1] imgH:_imageHeightArray[_imageNameArray.count-1]];
    
    _leftScrollH = [self getImageHWithImgW:_imageWidthArray[_imageNameArray.count-2] imgH:_imageHeightArray[_imageNameArray.count-2]];
    
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[_imageNameArray.count-2]]];
    
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_imageNameArray[_imageNameArray.count-1]]];
    
    currentImage = _imageNameArray.count-2;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _currentOffSet = scrollView.contentOffset.x;
    self.contentSize = CGSizeMake(SCREEN_WIDTH*3, self.size.height);
}

/**
 *  控制图片（scrollview）的缩放
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    CGFloat offsetValue = offset - _currentOffSet;
    CGFloat offsetX = 0.0;
    
    if (offsetValue > 0) {         //左滑
        offsetX = offsetValue;
        CGFloat value = _centerScrollH - _rightScrollH;
        CGFloat scale = value/SCREEN_WIDTH;     //单位位移下的缩放的距离
        if (value > 0) {    //缩小
            self.size = CGSizeMake(SCREEN_WIDTH, _centerScrollH-scale*offsetX);
        }else if (value < 0){   //放大
            self.size = CGSizeMake(SCREEN_WIDTH, _centerScrollH-scale*offsetX);
        }
    }else if (offsetValue < 0){                  //右滑
        offsetX = _currentOffSet - offset;
        CGFloat value = _centerScrollH - _leftScrollH;
        CGFloat scale = value/SCREEN_WIDTH;
        if (value > 0) {    //缩小
            self.size = CGSizeMake(SCREEN_WIDTH, _centerScrollH-scale*offsetX);
        }else if (value < 0){   //放大
            self.size = CGSizeMake(SCREEN_WIDTH, _centerScrollH-scale*offsetX);
        }

    }else{
        return;
    }

    self.contentSize = CGSizeMake(SCREEN_WIDTH * 3, self.size.height);
    _leftImageView.size = _centerImageView.size = _rightImageView.size = CGSizeMake(SCREEN_WIDTH, UISCREENHEIGHT);
//    NSLog(@"******* %lf",self.height);
    
    if ([self.mcDelegate respondsToSelector:@selector(MCScrollViewDidScroll:viewHeight:)]) {
        [self.mcDelegate MCScrollViewDidScroll:scrollView viewHeight:UISCREENHEIGHT];
    }
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"*********** %lf  %lf  %lf",_leftScrollH,_centerScrollH,_rightScrollH);
    scrollView.userInteractionEnabled = YES;
    
    if (self.contentOffset.x == 0){
        realImage = currentImage - 1;
    }else if (self.contentOffset.x == SCREEN_WIDTH*2){
        realImage = currentImage + 1;
    }else{
        realImage = currentImage;
    }
    
    if (realImage == 0){
        [self getImageFirst];
        return;
    }
    if (realImage == _imageNameArray.count-1) {
        [self getImageLast];
        return;
    }
    
    if (self.contentOffset.x == 0){
        currentImage = (currentImage-1)%_imageNameArray.count;
    }else if(self.contentOffset.x == SCREEN_WIDTH * 2){
        currentImage = (currentImage+1)%_imageNameArray.count;
    }else if(realImage == 1 || realImage == _imageNameArray.count-2){
        
    }else{
        return;
    }
    
    [self getImageData];
    
    self.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    if ([self.mcDelegate respondsToSelector:@selector(MCScrollViewDidEndDecelerating:)]) {
        [self.mcDelegate MCScrollViewDidEndDecelerating:scrollView];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate) {
        scrollView.userInteractionEnabled = NO;
    }
}


-(CGFloat)getImageHWithImgW:(NSString *)imgW imgH:(NSString *)imgH{
    CGFloat width = [imgW floatValue];
    CGFloat height = [imgH floatValue];
    
    return SCREEN_WIDTH/width * height;
}


@end
