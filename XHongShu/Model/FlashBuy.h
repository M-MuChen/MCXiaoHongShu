//
//  FlashBuy.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FlashBuy :JSONModel

@property (nonatomic, copy) NSString *flashBuyIdentifier;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *link;

@end
