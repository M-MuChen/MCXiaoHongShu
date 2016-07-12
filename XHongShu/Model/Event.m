//
//  Event.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "Event.h"
#import "GoodsList.h"

@implementation Event

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"eventIdentifier",@"discount_info":@"discountInfo",@"goods_list":@"goodsList"}];
}
@end
