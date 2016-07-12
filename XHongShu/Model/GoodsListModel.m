//
//  Data.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "GoodsListModel.h"
#import "ImagesList.h"
#import "User.h"
#import "Recommend.h"

@implementation GoodsListModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"relatedgoods_list":@"relatedgoodsList",@"share_link":@"shareLink",@"newest_comments":@"newestComments",@"images_list":@"imagesList",@"id":@"dataIdentifier",@"show_more":@"showMore",@"cursor_score":@"cursorScore",@"fav_count":@"favCount",@"short_name":@"shortName",@"discount_price":@"discountPrice",@"goods_left":@"goodsLeft",@"sold_out":@"soldOut"}];
}
@end
