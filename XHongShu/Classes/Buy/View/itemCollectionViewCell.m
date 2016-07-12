//
//  itemCollectionViewCell.m
//  XHongShu
//
//  Created by 宋江 on 16/6/29.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "itemCollectionViewCell.h"

@implementation itemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"itemCollectionViewCell" owner:self options:nil];
        self = [array lastObject];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setCategoryModel:(CategoryModel *)categoryModel{
    _categoryModel = categoryModel;
    self.itemName.text = _categoryModel.name;
}
@end
