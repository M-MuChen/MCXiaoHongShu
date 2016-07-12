//
//  Data.h
//
//  Created by  万霆 on 16/6/16
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AddFriendsModel :JSONModel

@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *fstatus;
@property (nonatomic, assign) double score;
@property (nonatomic, copy) NSString *recommendInfo;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *images;
@property (nonatomic, strong) NSArray *notesList;
@property (nonatomic, copy) NSString *recommendTrackId;

@end
