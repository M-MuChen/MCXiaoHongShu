//
//  ThematicActivityCell.m
//  XHongShu
//
//  Created by 宋江 on 16/6/2.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "ThematicActivityCell.h"
#import <UIImageView+WebCache.h>
@implementation ThematicActivityCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCell];
        
    }
    return self;
    
}
- (void)createCell{

    _specialImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH- 30, 180)];
    _specialImageView.layer.cornerRadius = 5;
    _specialImageView.clipsToBounds = YES;
    [self addSubview:_specialImageView];
}
- (void)setAlbumModel:(MoreAlbumModel *)albumModel{
    _albumModel = albumModel;
    [self setValue];
    
}
- (void)setValue{
    [_specialImageView sd_setImageWithURL:[NSURL URLWithString: _albumModel.image]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
