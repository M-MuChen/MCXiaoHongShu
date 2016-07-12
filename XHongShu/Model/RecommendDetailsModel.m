//
//  Data.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "RecommendDetailsModel.h"
#import "GoodsList.h"
#import "FlashBuy.h"
#import "Tags.h"

@implementation RecommendDetailsModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"goods_list":@"goodsList",@"flash_buy":@"flashBuy",@"share_link":@"shareLink",@"pre_store":@"preStore",@"discount_info":@"discountInfo",@"top_notification":@"topNotification",@"default_mode":@"defaultMode",@"show_barrage":@"showBarrage",@"total_goods":@"totalGoods"}];
}
@end
