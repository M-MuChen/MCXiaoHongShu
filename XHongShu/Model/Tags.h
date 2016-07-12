//
//  Tags.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Tags :JSONModel

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong)NSNumber *discoveryTotal;
@property (nonatomic, copy) NSString *tagsIdentifier;
@property (nonatomic, copy) NSString *id1;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) BOOL processed;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, assign) BOOL inAction;
@property (nonatomic, copy) NSString *name;


@end
