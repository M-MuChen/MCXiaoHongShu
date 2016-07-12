//
//  MCPicModle.h
//  PortableTreasure
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCPicModle : NSObject

/**
 *  上传的图片的名字
 */
@property (nonatomic, copy) NSString *picName;

/**
 *  上传的图片
 */
@property (nonatomic, strong, nullable) UIImage *pic;

/**
 *  上传的二进制文件
 */
@property (nonatomic, strong) NSData *picData;

/**
 *  上传的资源url
 */
@property (nonatomic, copy) NSString *url;

@end

NS_ASSUME_NONNULL_END