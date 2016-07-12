//
//  CommentDetailsModel.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//
#import <JSONModel/JSONModel.h>

@interface CommentDetailsModel : JSONModel

@property (nonatomic, strong)NSNumber *result;
@property (nonatomic, strong)NSNumber *count;
@property (nonatomic, strong) NSArray *newestComments;
@property (nonatomic, strong) NSArray *hotComments;


@end
