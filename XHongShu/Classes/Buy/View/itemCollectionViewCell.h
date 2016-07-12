//
//  itemCollectionViewCell.h
//  XHongShu
//
//  Created by 宋江 on 16/6/29.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
@interface itemCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)CategoryModel *categoryModel;

@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *selectedLine;
@end
