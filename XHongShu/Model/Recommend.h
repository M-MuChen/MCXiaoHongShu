//
//  Recommend.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@interface Recommend : JSONModel

@property (nonatomic, copy) NSString *targetName;
@property (nonatomic, copy) NSString *targetId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *trackId;


@end
