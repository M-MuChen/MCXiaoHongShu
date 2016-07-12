//
//  TagsInfoModel.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//
#import <JSONModel/JSONModel.h>

@class Position;

@interface TagsInfoModel : JSONModel

@property (nonatomic, copy) NSString *oid;
@property (nonatomic, strong)NSNumber *angle;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) Position *position;
@property (nonatomic, copy) NSString *name;

@end
