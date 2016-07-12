//
//  Data.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "ForDetailsModel.h"
#import "Tags.h"
#import "LikeUsers.h"
#import "NewestComments.h"
#import "ImagesList.h"
#import "User.h"

@implementation ForDetailsModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"relatedgoods_list":@"relatedgoodsList",@"like_users":@"likeUsers",@"share_link":@"shareLink",@"newest_comments":@"newestComments",@"images_list":@"imagesList",@"id":@"dataIdentifier",@"tags_info_2":@"tagsInfo2",@"fav_count":@"favCount",@"hot_comments":@"hotComments"}];
}

@end
