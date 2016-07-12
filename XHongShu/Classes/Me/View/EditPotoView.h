//
//  EditPotoView.h
//  XHongShu
//
//  Created by 宋江 on 16/6/8.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditPotoModel.h"
@interface EditPotoView : UIView

@property (nonatomic,strong)UIButton *nameBtn1;
@property (nonatomic,strong)UIButton *nameBtn2;

- (instancetype)initWithFrame:(CGRect)frame nameArray:(NSArray *)nameArray;
@property (nonatomic,assign)int type;

@property (nonatomic,strong)NSArray *filterGalleryArray;
@property (nonatomic,strong)NSArray *beautifyPhotosArray;

@property (nonatomic,strong)NSArray *activityStickersArray;
@property (nonatomic,strong)NSArray *myStickerArray;


@property (nonatomic,strong)EditPotoModel *editPotoModel;




@end
