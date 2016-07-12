//
//  MCHub.m
//  XHongShu
//
//  Created by 周陆洲 on 16/6/16.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MCHub.h"

@implementation MCHub

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *imageNameArray = @[@"xy_loading_1~iphone",@"xy_loading_1~iphone",@"xy_loading_2~iphone",@"xy_loading_3~iphone",@"xy_loading_4~iphone",@"xy_loading_5~iphone",@"xy_loading_6~iphone",@"xy_loading_7~iphone",@"xy_loading_8~iphone",@"xy_loading_9~iphone",@"xy_loading_10~iphone",@"xy_loading_11~iphone",@"xy_loading_12~iphone",@"xy_loading_13~iphone",@"xy_loading_14~iphone",@"xy_loading_15~iphone",@"xy_loading_16~iphone",@"xy_loading_17~iphone",@"xy_loading_18~iphone",@"xy_loading_19~iphone",@"xy_loading_20~iphone",@"xy_loading_21~iphone",@"xy_loading_22~iphone",@"xy_loading_23~iphone",@"xy_loading_24~iphone",@"xy_loading_25~iphone",@"xy_loading_26~iphone",@"xy_loading_27~iphone",@"xy_loading_28~iphone",@"xy_loading_29~iphone",@"xy_loading_30~iphone",@"xy_loading_31~iphone",@"xy_loading_32~iphone"];
        
        NSMutableArray *imageArray = [NSMutableArray array];
        for (NSString *imageStr in imageNameArray) {
            UIImage *image = [UIImage imageNamed:imageStr];
            [imageArray addObject:image];
        }
        
        self.animationImages = imageArray;
        self.animationDuration = 3.0;
        [self startAnimating];
    }
    
    return self;
}

@end
