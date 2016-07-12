//
//  Data.m
//
//  Created by  万霆 on 16/6/3
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "FollowTagsModel.h"
@implementation FollowTagsModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"likes_total":@"likesTotal",@"id":@"dataIdentifier",@"discovery_total":@"discoveryTotal"}];
}
@end
