//
//  Banners.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "Banners.h"
#import "Recommends.h"
#import "Scenario.h"
#import "DestinationModel.h"

@implementation Banners

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"show_more":@"showMore",@"total_follows":@"totalfollows"}];
}

@end
