//
//  Data.h
//
//  Created by  万霆 on 16/6/3
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FollowTagsModel :JSONModel

@property (nonatomic, assign) double likesTotal;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, assign) BOOL inlikes;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *oid;
@property (nonatomic, strong) NSString *ename;
@property (nonatomic, assign) double discoveryTotal;
@property (nonatomic, strong) NSString *name;

@end
