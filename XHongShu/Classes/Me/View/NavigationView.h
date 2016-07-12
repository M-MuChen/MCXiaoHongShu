//
//  WrapBarView.h
//  AllCodeDataNew
//
//  Created by 宋江 on 16/4/18.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlBar.h"

@interface NavigationView : UIView

@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)ControlBar *controlBar;
@property (nonatomic,strong)NSMutableArray *controlArray;

- (instancetype)initWithFrame:(CGRect)frame name:(NSArray *)nameArray;

@end
