//
//  User.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@interface User :JSONModel

@property (nonatomic, copy) NSString *images;
@property (nonatomic, copy) NSString *fstatus;
@property (nonatomic, strong)NSNumber *redClubLevel;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) BOOL isbirthday;
@property (nonatomic, strong)NSNumber *fansTotal;
@property (nonatomic, strong)NSNumber *discoverysTotal;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, strong)NSNumber *likes;
@property (nonatomic, assign) BOOL redClub;

@property (nonatomic, copy) NSString *userIdentifier;
@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) BOOL followed;


@end
