//
//  NewestComments.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//
#import <JSONModel/JSONModel.h>

@class User;

@interface NewestComments :JSONModel

@property (nonatomic, strong)NSNumber *likeCount;
@property (nonatomic, copy) NSString *newestCommentsIdentifier;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL liked;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) User *user;


@end
