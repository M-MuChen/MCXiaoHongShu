//
//  Auxiliary.h
//  nushroom
//
//  Created by yiliu on 15/5/11.
//  Copyright (c) 2015年 nushroom. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Auxiliary : NSObject

/**
 *自适应高度宽度
 */
+ (CGSize)CalculationHeightWidth:(NSString *)str andSize:(float)fot andCGSize:(CGSize)size;

/**
 *获取网络图片文件名
 */
+ (NSString *)GetFileName:(NSString *)path;

/**
 *返回图片的位置CGRect(美途)
 */
+ (CGRect)CalculationCGRect:(float)i andY:(float)y;

/**
 *返回图片的位置CGRect(留言板)
 */
+ (CGRect)CalculationMassageCGRect:(float)i andY:(float)y;

/**
 *MD5加密
 */
+ (NSString *)md5:(NSString *)str;

/**
 *字符串转url
 */
+ (NSURL *)urlTransformation:(NSString *)str;

/**
 *url转字符串
 */
+ (NSString *)strTransformation:(NSURL *)url;

/**
 *图片合成
 */
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 subRect:(CGRect)rect;

/**
 *保存图片到沙盒
 */
+ (BOOL)SavePictures:(UIImage *)image andName:(NSString *)name;

/**
 *旋转图片
 */
+ (UIImage*)buildImage:(UIImage*)image andJD:(float)jd;

/**
 *滤镜
 */
+(UIImage *)changeImage:(int)index imageView:(UIImage *)imageTp;

@end
