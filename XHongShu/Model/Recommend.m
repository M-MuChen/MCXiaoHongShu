//
//  Recommend.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "Recommend.h"
@implementation Recommend

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"target_name":@"targetName",@"target_id":@"targetId",@"track_id":@"trackId"}];
}
@end
