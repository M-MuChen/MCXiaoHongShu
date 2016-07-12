//
//  SelectLabelViewController.h
//  XHongShu
//
//  Created by 宋江 on 16/6/12.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^ValueBlock)(NSString *value);

@interface SelectLabelViewController : UIViewController
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,copy)ValueBlock valueBlock;

@end
