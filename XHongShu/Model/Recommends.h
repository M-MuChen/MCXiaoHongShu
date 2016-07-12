//
//  Recommends.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class User;

@interface Recommends :JSONModel

@property (nonatomic, copy) NSString *oid;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) User *user;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) NSString *link;


@end
