//
//  CrossFieldCollectionView.h
//  XHongShu
//
//  Created by 宋江 on 16/6/17.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "GoodsList.h"
@interface CrossFieldCollectionView : UIView
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)Event *eventModel;
@property (nonatomic,strong)GoodsList *goodsList;
@end
