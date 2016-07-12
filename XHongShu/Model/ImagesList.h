//
//  ImagesList.h
//
//  Created by  万霆 on 16/5/30
//  Copyright (c) 2016 万霆. All rights reserved.
//
#import <JSONModel/JSONModel.h>

@interface ImagesList :JSONModel

@property (nonatomic, copy) NSString *original;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong)NSString *height;
@property (nonatomic, strong)NSString *width;

@end
