//
//  EditPotoCollectionView.h
//  XHongShu
//
//  Created by 宋江 on 16/6/8.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SpecialEffectsDelegate <NSObject>

@optional

- (void)SpecialEffectsIndex:(NSInteger)index;

@end
@interface EditPotoCollectionView : UIView

@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic,strong) id<SpecialEffectsDelegate> delegate;

@end
