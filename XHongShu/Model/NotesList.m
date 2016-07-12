//
//  NotesList.m
//
//  Created by  万霆 on 16/6/16
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import "NotesList.h"
@implementation NotesList

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper

{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"notesListIdentifier"}];
}

@end
