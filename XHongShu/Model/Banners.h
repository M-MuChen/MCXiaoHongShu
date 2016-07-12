//
//  Banners.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class DestinationModel;

@interface Banners :JSONModel

@property (nonatomic, strong) NSArray *recommends;
@property (nonatomic, strong) NSArray *brands;
@property (nonatomic, assign) BOOL showMore;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, strong) NSArray *boards;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSArray *scenario;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *oid;
@property (nonatomic, strong) DestinationModel *destination;
@property (nonatomic, copy) NSString *totalFollows;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *events;

@end
