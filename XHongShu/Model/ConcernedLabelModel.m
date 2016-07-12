//
//  Data.m
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "ConcernedLabelModel.h"
#import "Banners.h"

@implementation ConcernedLabelModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"search_placeholder":@"searchPlaceholder"}];
}
@end
