//
//  EditPotoModel.h
//  XHongShu
//
//  Created by 宋江 on 16/6/12.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class PotoNameModel;
@interface EditPotoModel : JSONModel
@property (nonatomic,strong)PotoNameModel *potoNameModel;
@property (nonatomic,copy)NSString *filterGallery;
@property (nonatomic,copy)NSString *beautifyPhotos;
@property (nonatomic,copy)NSString *activityStickers;
@property (nonatomic,copy)NSString *mySticker;
@end
