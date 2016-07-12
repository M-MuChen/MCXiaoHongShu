//
//  XTPasterStageView.h
//  XTPasterManager
//
//  Created by apple on 15/7/8.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddLabelDelegate <NSObject>
- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)gesture;
@end

@interface XTPasterStageView : UIView

@property (nonatomic,strong) UIImage *originImage ;
@property (nonatomic,strong) UIImageView    *imgView ;
- (instancetype)initWithFrame:(CGRect)frame ;
- (void)addPasterWithImg:(UIImage *)imgP ;
- (UIImage *)doneEdit ;

@property (nonatomic,weak)id<AddLabelDelegate> delegate;

@end
