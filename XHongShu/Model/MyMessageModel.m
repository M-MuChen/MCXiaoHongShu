//
//  Data.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "MyMessageModel.h"
#import "Level.h"

@implementation MyMessageModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"user_token":@"userToken",@"red_id":@"redId",@"red_club":@"redClub",@"red_id_can_edit":@"redIdCanEdit",@"following_tags":@"followingTags",@"share_link":@"shareLink",@"following_boards":@"followingBoards",@"order_list_link":@"orderListLink",@"easemob_password":@"easemobPassword",@"red_club_level":@"redClubLevel"}];
}
@end
