//
//  HotComments.m
//  XHongShu
//
//  Created by 周陆洲 on 16/6/17.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "HotComments.h"

@implementation HotComments
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"userIdentifier",@"like_count":@"likeCount"}];
}
@end
