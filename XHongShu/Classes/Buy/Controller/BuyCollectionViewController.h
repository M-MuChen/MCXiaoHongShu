//
//  BuyCollectionViewController.h
//  XHongShu
//
//  Created by 宋江 on 16/6/16.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendGoodsModel.h"
#import "GoodsListModel.h"
#import "Event.h"
@interface BuyCollectionViewController : UIViewController

@property (nonatomic,strong)RecommendGoodsModel *recommendGoodsModel;
@property (nonatomic,strong)GoodsListModel *goodsListModel;
@property (nonatomic,strong)Event *eventModel;

/**
 *  url端口
 */
@property(nonatomic,copy) NSString *urlString;

@property (nonatomic,assign) NSUInteger indexs;
@end
