//
//  HotComments.h
//  XHongShu
//
//  Created by 周陆洲 on 16/6/17.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface HotComments : JSONModel

@property (nonatomic, strong) NSString *userIdentifier;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, assign) BOOL liked;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) User *user;

@end
