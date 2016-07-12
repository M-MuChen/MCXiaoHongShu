//
//  NSString+FileSize.h
//  ZhiZhu
//
//  Created by 周陆洲 on 15/12/4.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FileSize)

/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font lineSpacing:(CGFloat)spacing maxSize:(CGSize)maxSize;

/**
 *  获取文件夹大小
 */
- (long long)fileSize;


-(NSString *)scalesImageToFit;
- (NSString *)disable_emoji;
@end
