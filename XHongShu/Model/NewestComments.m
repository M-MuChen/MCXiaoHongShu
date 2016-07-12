//
//  NewestComments.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "NewestComments.h"
#import "User.h"

@implementation NewestComments

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"newestCommentsIdentifier",@"like_count":@"likeCount"}];
}
@end
