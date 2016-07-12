//
//  PotoTableView.h
//  XHongShu
//
//  Created by 宋江 on 16/6/8.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@protocol PotoTableViewDelegate <NSObject>
- (void)titleViewName:(NSString *)name groupName:(ALAssetsGroup*)groupName;
@end
@interface PotoTableView : UITableView
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)NSArray *groupArray;
@property (nonatomic,weak)id<PotoTableViewDelegate> delegate1;

@end
