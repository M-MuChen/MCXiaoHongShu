//
//  Data.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class Level;

@interface MyMessageModel : JSONModel

@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *userToken;
@property (nonatomic, strong)NSNumber *nboards;
@property (nonatomic, copy) NSString *redId;
@property (nonatomic, assign) BOOL redClub;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) BOOL redIdCanEdit;
@property (nonatomic, strong)NSNumber *followingTags;
@property (nonatomic, copy) NSString *shareLink;
@property (nonatomic, strong)NSNumber *ndiscovery;
@property (nonatomic, assign) BOOL isgroupmember;
@property (nonatomic, copy) NSString *images;
@property (nonatomic, strong)NSNumber *followingBoards;
@property (nonatomic, copy) NSString *orderListLink;
@property (nonatomic, strong)NSNumber *follows;
@property (nonatomic, copy) NSString *imageb;
@property (nonatomic, strong)NSNumber *redclubscore;
@property (nonatomic, strong)NSNumber *score;
@property (nonatomic, copy) NSString *session;
@property (nonatomic, copy) NSString *easemobPassword;
@property (nonatomic, strong)NSNumber *gender;
@property (nonatomic, strong)NSNumber *historyscore;
@property (nonatomic, strong) Level *level;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong)NSNumber *fans;
@property (nonatomic, strong)NSNumber *redClubLevel;
@property (nonatomic, copy) NSString *desc;


@end
