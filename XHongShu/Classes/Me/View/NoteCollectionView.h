//
//  noteCollectionView.h
//  XHongShu
//
//  Created by 宋江 on 16/6/2.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectPhonesDelegate<NSObject>
- (void)selectPhones;
@end

@interface NoteCollectionView : UIView

@property (nonatomic,strong)id<selectPhonesDelegate>delegate;

@end
