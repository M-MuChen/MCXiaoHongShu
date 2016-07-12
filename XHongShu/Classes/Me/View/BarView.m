//
//  BarView.m
//  XHongShu
//
//  Created by 宋江 on 16/6/14.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BarView.h"
#import "PasterChooseView.h"
static const CGFloat width_pasterChoose = 110.0f ;
//@interface BarView ()<UIScrollViewDelegate,PasterChooseViewDelegate>
//{
//    UIScrollView *_scrollPaster;
//}
//
//@end
@implementation BarView
//- (instancetype)initWithFrame:(CGRect)frame nameArray:(NSArray *)nameArray{
//    self = [super initWithFrame];
//    if (self) {
//
//        [self createWithFrame:frame];
//        
//    }
//    return self;
//}
//- (void)createWithFrame:(CGRect)frame{
//    
//    _scrollPaster = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.bounds.size.height -30)];
//    _scrollPaster.delegate = self ;
//    _scrollPaster.pagingEnabled = NO ;
//    _scrollPaster.showsVerticalScrollIndicator = NO ;
//    _scrollPaster.showsHorizontalScrollIndicator = NO ;
//    _scrollPaster.bounces = YES ;
//    _scrollPaster.contentSize = CGSizeMake(width_pasterChoose * self.pasterList.count,
//                                           _scrollPaster.frame.size.height) ;
//    [self addSubview:_scrollPaster];
//    
//    int _x = 0 ;
//    
//    for (int i = 0; i < self.pasterList.count; i++)
//    {
//        CGRect rect = CGRectMake(_x, 0, SCREEN_WIDTH, _scrollPaster.frame.size.height) ;
//        PasterChooseView *pView = (PasterChooseView *)[[[NSBundle mainBundle] loadNibNamed:@"PasterChooseView" owner:self options:nil] lastObject] ;
//        pView.backgroundColor = [UIColor whiteColor];
//        pView.frame = rect ;
//        
//        pView.aPaster = self.pasterList[i] ;
//        
//        pView.delegate = self ;
//        [_scrollPaster addSubview:pView] ;
//        
//        _x += width_pasterChoose ;
//    }
//    
//
//
//}

@end
