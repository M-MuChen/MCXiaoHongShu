//
//  Scenario.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//


#import <JSONModel/JSONModel.h>

@interface Scenario : JSONModel

@property (nonatomic, copy) NSString *scenarioIdentifier;
@property (nonatomic, copy) NSString *bindedTagOid;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *oid;
@property (nonatomic, copy) NSString *totalFollows;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *name;


@end
