//
//  Data.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RecommendDetailsModel : JSONModel

@property (nonatomic, strong) NSArray *goodsList;
@property (nonatomic, copy) NSString *shareLink;
@property (nonatomic, strong) NSArray *flashBuy;
@property (nonatomic, assign) BOOL preStore;
@property (nonatomic, copy) NSString *discountInfo;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *topNotification;
@property (nonatomic, copy) NSString *defaultMode;
@property (nonatomic, assign) BOOL showBarrage;
@property (nonatomic, strong) NSNumber *totalGoods;


@end
