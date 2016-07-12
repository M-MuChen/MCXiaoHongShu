//
//  NotesDetailViewController.h
//  XHongShu
//
//  Created by 周陆洲 on 16/6/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsListModel;
#import "MCScrollView.h"
@interface NotesDetailViewController : UIViewController

@property (nonatomic, strong) GoodsListModel *goodsModel;
@property (nonatomic, strong) UIImage *userHead;

@property (nonatomic, strong) NSDictionary *imgDic;
@property (nonatomic, strong) UIImage *firstImage;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSNumber *likes;
@property (nonatomic, strong) NSNumber *favCount;

@property (nonatomic, strong)MCScrollView *imageScrollView;

@end
