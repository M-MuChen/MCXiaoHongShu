//
//  Data.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ConcernedPeopleModel :JSONModel

@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *fstatus;
@property (nonatomic, copy) NSString *images;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, strong)NSNumber *ndiscovery;
@property (nonatomic, copy) NSString *rid;
@property (nonatomic, strong)NSNumber *fans;
@property (nonatomic, strong)NSNumber *likes;
@property (nonatomic, copy) NSString *desc;


@end
