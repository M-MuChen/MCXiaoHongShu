//
//  Tags.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "Tags.h"
@implementation Tags

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"tagsIdentifier",@"discovery_total":@"discoveryTotal",@"display_name":@"displayName",@"in_action":@"inAction"}];
}
@end
