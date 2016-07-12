//
//  FollowItem.h
//  XHongShu
//
//  Created by 宋江 on 16/6/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowItem : UIControl

@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *nameLabel;
/**
 *  创建个人导航条
 *
 *  @param count 数量
 *  @param name  标题
 *
 */
- (instancetype)initWithName:(NSString *)name size:(CGSize)size;
@end
