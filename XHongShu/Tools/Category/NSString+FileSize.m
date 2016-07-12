//
//  NSString+FileSize.m
//  ZhiZhu
//
//  Created by 周陆洲 on 15/12/4.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import "NSString+FileSize.h"

@implementation NSString (FileSize)

/**
 *  获取文字尺寸
 *
 *  @param font    文字
 *  @param maxSize 最大尺寸
 *
 */
- (CGSize)sizeWithFont:(UIFont *)font lineSpacing:(CGFloat)spacing maxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:spacing];
    
    NSDictionary *attrs = @{NSFontAttributeName : font, NSParagraphStyleAttributeName : paragraphStyle};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:attrs context:nil].size;
}


/**
 *  获取文件大小
 *
 */
- (long long)fileSize
{
    // 1.文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.判断file是否存在
    BOOL isDirectory = NO;
    BOOL fileExists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    // 文件\文件夹不存在
    if (fileExists == NO) return 0;
    
    // 3.判断file是否为文件夹
    if (isDirectory) { // 是文件夹
        NSArray *subpaths = [mgr contentsOfDirectoryAtPath:self error:nil];
        long long totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            totalSize += [fullSubpath fileSize];
        }
        return totalSize;
    } else { // 不是文件夹, 文件
        // 直接计算当前文件的尺寸
        NSDictionary *attr = [mgr attributesOfItemAtPath:self error:nil];
        return [attr[NSFileSize] longLongValue];
    }
}


/**
 *  调整webview中图片尺寸
 *
 */
-(NSString *)scalesImageToFit
{
    CGFloat imgWidth = SCREEN_WIDTH - 24;
    NSString *contentStr = [NSString stringWithFormat:@"<html><head><style>img{width:%fpx !important;}p{word-wrap:break-word;}body{font-size:15px;color:#8F8F8F}</style></head>%@</html>",imgWidth,self];
    return contentStr;
}

/**
 *  过滤系统表情
 *
 */
- (NSString *)disable_emoji
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    if ([modifiedString isEqualToString:@""]) {
        modifiedString = @".";
    }
    return modifiedString;
}

@end
