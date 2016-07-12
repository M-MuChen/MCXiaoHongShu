//
//  CollectionCellFrame.h
//  XHongShu
//
//  Created by 周陆洲 on 16/6/3.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GoodsListModel.h"
@interface CollectionCellFrame : NSObject

@property (nonatomic,strong) GoodsListModel *goodsModel;

@property (nonatomic,assign) CGFloat imageH;
@property (nonatomic,assign) CGSize itemSize;

@property (nonatomic,strong) UIImage *itemImage;

@end
