//
//  Data.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class User;
@class NewestComments;
@class HotComments;

@interface ForDetailsModel : JSONModel

@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong)NSNumber *likes;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSArray *relatedgoodsList;
@property (nonatomic, strong) NSArray *likeUsers;
@property (nonatomic, copy) NSString *shareLink;
@property (nonatomic, assign) BOOL inlikes;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<NewestComments*> *newestComments;
@property (nonatomic, strong) NSArray *imagesList;
@property (nonatomic, copy) NSString *geo;
@property (nonatomic, copy) NSString *dataIdentifier;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong)NSNumber *level;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, copy) NSString *tagsInfo2;
@property (nonatomic, assign) BOOL infavs;
@property (nonatomic, strong)NSNumber *comments;
@property (nonatomic, strong)NSNumber *favCount;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSArray<HotComments*> *hotComments;


@end
