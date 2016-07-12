//
//  Auxiliary.m
//  nushroom
//
//  Created by yiliu on 15/5/11.
//  Copyright (c) 2015年 nushroom. All rights reserved.
//

#import "Auxiliary.h"
#import <CommonCrypto/CommonDigest.h>
#import "ImageUtil.h"
#import "ColorMatrix.h"

@implementation Auxiliary

#pragma mark--自适应高度宽度
+ (CGSize)CalculationHeightWidth:(NSString *)str andSize:(float)fot andCGSize:(CGSize)size{
    
    UIFont * tfont = [UIFont systemFontOfSize:fot];
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    return [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
}

#pragma mark--获取网络图片文件名
+ (NSString *)GetFileName:(NSString *)path{
    NSString *filePath = path;
    NSArray *fileAry = [filePath componentsSeparatedByString:@"/"];
    if(fileAry.count > 0){
        return fileAry[fileAry.count-1];
    }
    return nil;
}

#pragma mark--返回图片的位置CGRect(美途)
+ (CGRect)CalculationCGRect:(float)i andY:(float)y{
    return CGRectMake(10+y*((SCREEN_WIDTH-30)/3+5), 60+i*((SCREEN_WIDTH-30)/3+5), (SCREEN_WIDTH-30)/3, (SCREEN_WIDTH-30)/3);
}

#pragma mark--返回图片的位置CGRect(留言板)
+ (CGRect)CalculationMassageCGRect:(float)i andY:(float)y{
    return CGRectMake(64+y*((SCREEN_WIDTH-84)/3+5), 60+i*((SCREEN_WIDTH-84)/3+5), (SCREEN_WIDTH-84)/3, (SCREEN_WIDTH-84)/3);
}

#pragma mark--md5加密
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

#pragma mark--字符串转url
+ (NSURL *)urlTransformation:(NSString *)str{
    NSString *urlStr = str;
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    return url;
}

#pragma mark--url转字符串
+ (NSString *)strTransformation:(NSURL *)url{
    return [[url absoluteString] stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}


#pragma mark--图片合成
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 subRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(image2.size);
    
    //Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    //Draw image1
    [image1 drawInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

#pragma mark--保存图片到沙盒
+ (BOOL)SavePictures:(UIImage *)image andName:(NSString *)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];// 保存文件的名称
    NSLog(@"filePath:%@",filePath);
    return [UIImagePNGRepresentation(image)writeToFile:filePath atomically:YES];
}

#pragma mark--旋转图片
+ (UIImage*)buildImage:(UIImage*)image andJD:(float)jd
{
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIAffineTransform" keysAndValues:kCIInputImageKey, ciImage, nil];
    
    [filter setDefaults];
    CGAffineTransform transform = CATransform3DGetAffineTransform([self rotateTransform:CATransform3DIdentity clockwise:NO andJD:jd]);
    [filter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
    
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return result;
}
+ (CATransform3D)rotateTransform:(CATransform3D)initialTransform clockwise:(BOOL)clockwise  andJD:(float)jd
{
    CGFloat arg = jd;
    if(!clockwise){
        arg *= -1;
    }
    
    CATransform3D transform = initialTransform;
    transform = CATransform3DRotate(transform, arg, 0, 0, 1);
    transform = CATransform3DRotate(transform, 0*M_PI, 0, 1, 0);
    transform = CATransform3DRotate(transform, 0*M_PI, 1, 0, 0);
    
    return transform;
}

#pragma mark--滤镜
+(UIImage *)changeImage:(int)index imageView:(UIImage *)imageTp
{
    UIImage *image;
    switch (index) {
        case 0:
        {
            return imageTp;
        }
            break;
        case 1:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_lomo];
        }
            break;
        case 2:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_heibai];
        }
            break;
        case 3:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_huajiu];
        }
            break;
        case 4:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_gete];
        }
            break;
        case 5:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_ruise];
        }
            break;
        case 6:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_danya];
        }
            break;
        case 7:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_jiuhong];
        }
            break;
        case 8:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_qingning];
        }
            break;
        case 9:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_langman];
        }
            break;
        case 10:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_guangyun];
        }
            break;
        case 11:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_landiao];
            
        }
            break;
        case 12:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_menghuan];
            
        }
            break;
        case 13:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_yese];
            
        }
    }
    return image;
}


@end
