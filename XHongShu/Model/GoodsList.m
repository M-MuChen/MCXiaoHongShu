//
//  GoodsList.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "GoodsList.h"

@implementation GoodsList

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"goodsListIdentifier",@"short_name":@"shortName",@"discount_price":@"discountPrice",@"goods_left":@"goodsLeft",@"sold_out":@"soldOut",@"total_price":@"totalPrice"}];
}
@end
