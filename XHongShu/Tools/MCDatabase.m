//
//  MCDatabase.m
//  ZhiZhu
//
//  Created by 周陆洲 on 16/1/18.
//  Copyright © 2016年 wt-vrs. All rights reserved.
//

#import "MCDatabase.h"
#import <FMDatabase.h>

#define pathString [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

static FMDatabase *_dataBase;

@implementation MCDatabase

/**
 *  创建数据库
 *
 *  @param dbName <#dbName description#>
 */
+(void)saveDataWithTableName:(NSString *)tableName{
    
    if (!_dataBase) {
        MCDatabase *db = [[MCDatabase alloc] init];
        _dataBase = [db getDatabase];
    }
    
    if ([_dataBase open]) {
        
        if ([tableName isEqualToString:@"recommendQues"]) {
            [_dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS recommendQues (id integer PRIMARY KEY AUTOINCREMENT, itemDict blob NOT NULL);"];
        }else if([tableName isEqualToString:@"newQues"]){
            [_dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS newQues (id integer PRIMARY KEY AUTOINCREMENT, itemDict blob NOT NULL);"];
        }
        
        NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT, itemDict blob NOT NULL);",tableName];
        [_dataBase executeQuery:sqlStr];
    }
    
}

/**
 *  将字典存入数据库
 *
 *  @param itemDict <#itemDict description#>
 */
+ (void)saveItemDict:(NSDictionary *)itemDict tableName:(NSString *)tableName{
    
    if (!_dataBase) {
        MCDatabase *db = [[MCDatabase alloc] init];
        _dataBase = [db getDatabase];
    }
    
    //此处把字典归档成二进制数据直接存入数据库，避免添加过多的数据库字段
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:itemDict];
    if ([tableName isEqualToString:@"recommendQues"]) {
        [_dataBase executeUpdateWithFormat:@"INSERT INTO recommendQues (itemDict) VALUES (%@);", dictData];
    }else if([tableName isEqualToString:@"newQues"]){
        [_dataBase executeUpdateWithFormat:@"INSERT INTO newQues (itemDict) VALUES (%@);", dictData];
    }

//    [_dataBase executeQuery:[NSString stringWithFormat:@"INSERT INTO recommendQues (itemDict) VALUES (%@);", dictData]];
}

/**
 *  将字典数组存入数据库
 *
 *  @param itemDictArray <#itemDict description#>
 */
+ (void)saveItemDictArray:(NSArray *)itemDictArray tableName:(NSString *)tableName {
    //此处把字典归档成二进制数据直接存入数据库，避免添加过多的数据库字段
    
    if ([_dataBase open]) {
        for (NSDictionary *dic in itemDictArray) {
            [self saveItemDict:dic tableName:tableName];
        }
    }
}


/**
 *  删除表
 *
 *  @param tableName <#tableName description#>
 */
+ (void)deleteData:(NSString *)tableName
{
    if (!_dataBase) {
        MCDatabase *db = [[MCDatabase alloc] init];
        _dataBase = [db getDatabase];
    }
    if ([_dataBase open]) {
        if ([tableName isEqualToString:@"recommendQues"]) {
            
            [_dataBase executeUpdate:@"delete from recommendQues;"];
        }else if([tableName isEqualToString:@"newQues"]){
            
            [_dataBase executeUpdate:@"delete from newQues;"];
        }
        
    }
}

/**
 *  返回全部数据
 *
 *  @param model <#model description#>
 *
 */
+ (NSArray *)getDataWithModel:(JSONModel *)model tableName:(NSString *)tableName {
    
    if (!_dataBase) {
        MCDatabase *db = [[MCDatabase alloc] init];
        _dataBase = [db getDatabase];
    }
    
    NSMutableArray *list = [NSMutableArray array];
    if ([_dataBase open]) {
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
        FMResultSet *set = [_dataBase executeQuery:sqlStr];
        while (set.next) {
            // 获得当前所指向的数据
            NSData *dictData = [set objectForColumnName:@"itemDict"];
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
            
            [list addObject:[[[model class] alloc] initWithDictionary:dict error:nil]];
        }
    }
    
    return list;
}


-(FMDatabase *)getDatabase
{
//    NSString *pathString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [pathString stringByAppendingPathComponent:@"database.db"];
    _dataBase = [FMDatabase databaseWithPath:path];
    
    return _dataBase;
}

@end
