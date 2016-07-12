//
//  User.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "User.h"
@implementation User

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"userIdentifier",@"red_club_level":@"redClubLevel",@"fans_total":@"fansTotal",@"discoverys_total":@"discoverysTotal",@"red_club":@"redClub"}];
}
@end
