//
//  ToolMothod.h
//  ZhiZhu
//
//  Created by wt-vrs on 15/11/12.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry.h>

typedef NS_ENUM(NSInteger, NetworkStatusType) {
    NetworkStatusWiFi,
    NetworkStatusWWAN,
    NetworkStatusNONet
};

@protocol PleaseLoginDelegate <NSObject>

- (void)pleaseLogin;  //登录

- (void)isSaveData; //保存资料
- (void)notSaveData; //不保存资料
@optional
- (void)goNewsVC; //消息弹窗
@end

@interface ToolMothod : NSObject

+(UIView *)createLineWithWidth:(CGFloat)width andHeight:(CGFloat)height andColor:(UIColor *)color;

+(NSString *)changeDateWithString:(NSString *)dateStr;

+(NSString *)changeDateTimeWithString:(NSString *)dateTimeStr;

+(NSMutableAttributedString *)getLineSpacing:(CGFloat)spacing text:(NSString *)str;

+(NSURL *)urlWithStr:(NSString *)urlStr;

+(void)alertView:(id)VC title:(NSString *)title;

-(void)newsAlertView:(id)VC title:(NSString *)title;

+(NSString *)getDateTimeString;

+ (void)bottomMoveTop:(UIViewController *)VC To:(UIViewController *)VC; //转场动画:从下往上

+ (void)topMoveBottom:(UIViewController *)VC; //转场动画:从上往下

+ (void)Gradient:(UIViewController *)VC;
//+ (NSString *)judgeTimeStr:(NSString *)timeStr;
-(void)saveDataAlertView:(id)VC;
@property (nonatomic,weak)id<PleaseLoginDelegate>delegate;
@end