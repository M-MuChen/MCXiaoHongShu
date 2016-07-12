//
//  NSDate+MCDate.h
//  ZhiZhu
//
//  Created by 周陆洲 on 15/12/4.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MCDate)

/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;


@end
