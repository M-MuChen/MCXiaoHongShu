//
//  Data.m
//
//  Created by  万霆 on 16/6/16
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "AddFriendsModel.h"
#import "NotesList.h"

@implementation AddFriendsModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"recommend_info":@"recommendInfo",@"recommend_track_id":@"recommendTrackId",@"notes_list":@"notesList"}];
}

@end
