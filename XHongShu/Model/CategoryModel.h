//
//  Data.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CategoryModel :JSONModel

@property (nonatomic, copy) NSString *dataIdentifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong)NSNumber *sequence;


@end
