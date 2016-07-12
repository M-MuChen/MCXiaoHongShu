//
//  Data.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//
#import <JSONModel/JSONModel.h>

@interface AlbumModel :JSONModel

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *dataIdentifier;
@property (nonatomic, strong)NSNumber *privacy;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong)NSNumber *total;

@end
