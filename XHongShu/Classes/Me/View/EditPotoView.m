
//
//  EditPotoView.m
//  XHongShu
//
//  Created by 宋江 on 16/6/8.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "EditPotoView.h"
#import "EditPotoCollectionView.h"
@interface EditPotoView()
{
    EditPotoCollectionView *_fristCollectionView;
    EditPotoCollectionView *_twoCollectionView;
}
@end
@implementation EditPotoView

- (instancetype)initWithFrame:(CGRect)frame nameArray:(NSArray *)nameArray{
    self = [super initWithFrame:frame];
    if (self) {
    
        _filterGalleryArray = [NSArray array];
        _activityStickersArray = [NSArray array];
        _beautifyPhotosArray = [NSArray array];
        _myStickerArray = [NSArray array];
        [self createWithFrame:frame nameArray:nameArray];
        
    }
    return self;
}
- (void)createWithFrame:(CGRect)frame nameArray:(NSArray *)nameArray{

    _nameBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 60, 20)];
    _nameBtn1.tag = 2000;
    _nameBtn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [_nameBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_nameBtn1 setTitle:nameArray[0] forState:UIControlStateNormal];
   
    [_nameBtn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nameBtn1];
    
    UIView *lineView = [ToolMothod createLineWithWidth:1.0 andHeight:20 andColor:[UIColor groupTableViewBackgroundColor]];
    lineView.frame = CGRectMake(CGRectGetMaxX(_nameBtn1.frame)+5, 10, 1.0, 20);
    [self addSubview:lineView];
    
    _nameBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame)+5, 10, 60, 20)];
    _nameBtn2.tag = 2001;
    _nameBtn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [_nameBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_nameBtn2 setTitle:nameArray[1] forState:UIControlStateNormal];
    [_nameBtn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nameBtn2];
    
  
    _fristCollectionView = [[EditPotoCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameBtn1.frame)+10, SCREEN_WIDTH,frame.size.height -30)];
    _fristCollectionView.tag = self.tag;
    [self addSubview:_fristCollectionView];
    
    
    _twoCollectionView = [[EditPotoCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameBtn1.frame)+10, SCREEN_WIDTH,frame.size.height -30)];
//    if (_type == 0 &&_nameBtn2.tag == 2001) {
//        _twoCollectionView.isBeautifyPhotos = YES;
//    }
    [self addSubview:_twoCollectionView];
    
   
}

- (void)click:(UIButton *)btn{
    
    if (btn.tag == 2000) {
        _fristCollectionView.hidden = YES;
        _twoCollectionView.hidden = NO;
        
       [_nameBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_nameBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    }else{
        _fristCollectionView.hidden = NO;
        _twoCollectionView.hidden = YES;
        
        [_nameBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_nameBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
- (void)setFilterGalleryArray:(NSArray *)filterGalleryArray{
    _filterGalleryArray = filterGalleryArray;
    _fristCollectionView.dataArray= _filterGalleryArray;
}
- (void)setActivityStickersArray:(NSArray *)activityStickersArray{
    _activityStickersArray = activityStickersArray;
    _fristCollectionView.dataArray = _activityStickersArray;
}
- (void)setBeautifyPhotosArray:(NSArray *)beautifyPhotosArray{
    _beautifyPhotosArray = beautifyPhotosArray;
     _twoCollectionView.dataArray = _beautifyPhotosArray;
}
- (void)setMyStickerArray:(NSArray *)myStickerArray{
    _myStickerArray = myStickerArray;
    _twoCollectionView.dataArray = _myStickerArray;
}
@end
