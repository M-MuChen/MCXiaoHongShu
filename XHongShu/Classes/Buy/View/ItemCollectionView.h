//
//  ItemCollectionView.h
//  XHongShu
//
//  Created by 宋江 on 16/6/29.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol changeItemDelegate <NSObject>
-(void)changeItem:(NSInteger)integer;
@end
@interface ItemCollectionView : UIView

@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,weak)id<changeItemDelegate> itemDelegate;

@end
