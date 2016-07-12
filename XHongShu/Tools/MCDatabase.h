//
//  MCDatabase.h
//  ZhiZhu
//
//  Created by 周陆洲 on 16/1/18.
//  Copyright © 2016年 wt-vrs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCDatabase : NSObject

+ (void)saveDataWithTableName:(NSString *)tableName;

+ (void)saveItemDict:(NSDictionary *)itemDict tableName:(NSString *)tableName;

+ (void)saveItemDictArray:(NSArray *)itemDictArray tableName:(NSString *)tableName;

+ (NSArray *)getDataWithModel:(JSONModel *)model tableName:(NSString *)tableName;

+ (void)deleteData:(NSString *)tableName;
@end
