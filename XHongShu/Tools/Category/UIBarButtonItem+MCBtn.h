//
//  UIBarButtonItem+MCBtn.h
//  ZhiZhu
//
//  Created by 周陆洲 on 15/12/7.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MCBtn)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

@end
