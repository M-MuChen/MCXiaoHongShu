//
//  MCNetworkingLogin.h
//  ZhiZhu
//
//  Created by 周陆洲 on 15/12/31.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface MCNetworkingLogin : NSObject

+ (void)postLogin:(NSString *)urlString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

+ (void)getLogin:(NSString *)urlString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;



+(void)startMultiPartUploadTaskWithURL:(NSString *)url
                           imagesArray:(NSArray *)images
                     parameterOfimages:(NSString *)parameter
                        parametersDict:(NSDictionary *)parameters
                      compressionRatio:(float)ratio
                              progress:(void(^)(NSProgress *uploadProgres))progressBlock
                          succeedBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))succeedBlock
                           failedBlock:(void(^)(NSURLSessionDataTask * task, id responseObject))failedBlock;
@end
