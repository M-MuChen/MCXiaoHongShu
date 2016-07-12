//
//  HomeViewController.h
//  XHongShu
//
//  Created by 周陆洲 on 16/5/24.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

/**
 *  记录当前点击的indexPath
 */
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, assign) CGRect finalCellRect;

@property (nonatomic, strong) UICollectionView *collectionView;

@end
