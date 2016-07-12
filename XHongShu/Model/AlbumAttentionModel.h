//
//  Data.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class User;

@interface AlbumAttentionModel :JSONModel

@property (nonatomic, copy) NSString *dataIdentifier;
@property (nonatomic, copy) NSString *fstatus;
@property (nonatomic, copy) NSString *shareLink;
@property (nonatomic, copy) NSString *lasttime;
@property (nonatomic, strong)NSNumber *likes;
@property (nonatomic, strong)NSNumber *total;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, strong) NSArray *imageb;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong)NSNumber *fans;
@property (nonatomic, strong)NSNumber *followers;
@property (nonatomic, strong)NSNumber *privacy;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) User *user;


@end
