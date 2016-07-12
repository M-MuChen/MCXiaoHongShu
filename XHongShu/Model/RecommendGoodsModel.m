//
//  Data.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "RecommendGoodsModel.h"
#import "Event.h"

@implementation RecommendGoodsModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"dataIdentifier",@"category_id":@"categoryId"}];
}
@end
