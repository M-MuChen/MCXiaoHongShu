//
//  Data.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//
#import <JSONModel/JSONModel.h>

@class User, Recommend;

@interface GoodsListModel :JSONModel

@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong)NSNumber *likes;
@property (nonatomic, strong) NSArray *relatedgoodsList;
@property (nonatomic, copy) NSString *shareLink;
@property (nonatomic, assign) BOOL inlikes;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *newestComments;
@property (nonatomic, strong) NSArray *imagesList;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *dataIdentifier;
@property (nonatomic, assign) BOOL showMore;
@property (nonatomic, strong)NSNumber *level;
@property (nonatomic, copy) NSString *geo;
@property (nonatomic, strong) User *user;
@property (nonatomic, copy) NSString *cursorScore;
@property (nonatomic, strong) Recommend *recommend;
@property (nonatomic, assign) BOOL infavs;
@property (nonatomic, strong)NSNumber *comments;
@property (nonatomic, strong)NSNumber *favCount;
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) BOOL preview;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, copy) NSString *discountPrice;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong)NSNumber *goodsLeft;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) BOOL soldOut;

@property (nonatomic, copy) NSString *imageb;


@end
