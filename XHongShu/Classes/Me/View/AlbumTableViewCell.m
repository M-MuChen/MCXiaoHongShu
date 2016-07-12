//
//  AlbumTableViewCell.m
//  XHongShu
//
//  Created by 宋江 on 16/6/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "AlbumTableViewCell.h"
#import "AlbumView.h"
@implementation AlbumTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCell];
        
    }
    return self;
    
}
- (void)createCell{
    AlbumView *albumView1 = [[AlbumView alloc]initWithFrame:CGRectMake(9, 0,(SCREEN_WIDTH - 27)/2, 227)];

    [self addSubview:albumView1];
    
    AlbumView *albumView2 = [[AlbumView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(albumView1.frame)+9, 0,(SCREEN_WIDTH - 27)/2, 227)];
    [self addSubview:albumView2];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
