//
//  GoodsList.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//
#import <JSONModel/JSONModel.h>

@interface GoodsList :JSONModel

@property (nonatomic, copy) NSString *goodsListIdentifier;
@property (nonatomic, copy) NSString *trait;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, strong) NSNumber *discountPrice;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSNumber *goodsLeft;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *whcode;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) BOOL soldOut;
@property (nonatomic, strong) NSNumber *totalPrice;


@end
