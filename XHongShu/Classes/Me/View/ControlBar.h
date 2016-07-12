//
//  ControlBar.h
//  ZhiZhu
//
//  Created by 宋江 on 16/3/9.
//  Copyright © 2016年 wt-vrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlBar : UIControl
@property(nonatomic,strong)UILabel *nameLabel;
/**
 *  创建导航条
 *  @param name  标题
 */
- (instancetype) initWithName :(NSString *)name size:(CGSize)size;
@end
