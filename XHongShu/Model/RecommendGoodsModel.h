//
//  Data.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class Event;

@interface RecommendGoodsModel : JSONModel

@property (nonatomic, strong)NSNumber *sequence;
@property (nonatomic, copy) NSString *dataIdentifier;
@property (nonatomic, strong) Event *event;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *type;


@end
