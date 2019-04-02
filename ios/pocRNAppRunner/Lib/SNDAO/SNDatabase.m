//
//  SNDatabase.m
//  DBProject
//
//  Created by wangbin on 15/12/17.
//  Copyright © 2015年 wangbin. All rights reserved.
//

#import "SNDatabase.h"
#import "FMDB.h"
//#import <EGODatabase.h>
//#import "SQLiteManager.h"

@interface SNDatabase ()

@property(nonatomic, copy) NSString *writablePath;

@property(nonatomic, strong) FMDatabase *database;
@property(nonatomic, assign) BOOL isDataBaseOpened;

//@property(nonatomic, strong) EGODatabase *egoDatabase;
//
//@property(nonatomic, strong) SQLiteManager *dbManager;

@end

@implementation SNDatabase

#pragma mark static
+ (void)createDirectoryAtPath:(NSString *)path {
    //不是沙盒路径
    NSRange range = [path rangeOfString:NSHomeDirectory()];
    if (!(range.length>0 && range.location==0)) {
        return;
    }
    
    //数据库目录
    NSString *dbDirectory = [path stringByDeletingLastPathComponent];;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:dbDirectory isDirectory:&isDir];
    if (!(isExist&&isDir))  {
        [fileManager createDirectoryAtPath:dbDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    //Documents目录iCloud不备份
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    range = [path rangeOfString:documentsDirectory];
    if (range.length>0 && range.location==0) {
        NSURL *pathURL = [NSURL fileURLWithPath:path];
        if ([[NSFileManager defaultManager] fileExistsAtPath:[pathURL path]]) {
            NSError *error = nil;
            BOOL success = [pathURL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
            if(!success){
                NSLog(@"Error excluding %@ from backup %@", [pathURL lastPathComponent], error);
            }
        }
    }
}

#pragma mark method
- (void)dealloc {
    [self close];
}

- (id)initWithPath:(NSString *)path {
    if (self = [super init]) {
        [SNDatabase createDirectoryAtPath:path];
        
        self.writablePath = path;
    }
    return self;
}

- (BOOL)open {
    return [self fmdbOpen];
}

- (BOOL)close {
    return [self fmdbClose];
}

- (BOOL)columnExists:(NSString*)columnName inTableWithName:(NSString*)tableName {
    return [self fmdbColumnExists:columnName inTableWithName:tableName];
}

- (BOOL)executeUpdate:(NSString*)sql parameters:(NSArray*)parameters {
    return [self fmdbExecuteUpdate:sql parameters:parameters];
    
    //    return [self egoDBexecuteUpdate:sql parameters:parameters];
    
    //    return [self smDBexecuteUpdate:sql parameters:parameters];
}

- (SNDatabaseResult *)executeQuery:(NSString*)sql parameters:(NSArray*)parameters {
    return [self fmdbExecuteQuery:sql parameters:parameters];
    
    //    return [self egoDBexecuteQuery:sql parameters:parameters];
    
    //    return [self smDBexecuteQuery:sql parameters:parameters];
}

- (BOOL)beginTransaction {
    return [_database beginTransaction];
}

- (BOOL)commit {
    return [_database commit];
}

- (BOOL)rollback {
    return [_database rollback];
}

#pragma mark fmdb
- (BOOL)fmdbOpen{
    if (_database) {
        return YES;
    }
    
    _database = [FMDatabase databaseWithPath:self.writablePath];
    BOOL success = [_database open];
    
    if (!success) {
//       success = [_database setKey:@"1234key"];
        NSLog(@"数据库开始加密");
    }
    
    if (success) {
        NSLog(@"数据库加密成功");
    }
    
    if (!success) {
        NSLog(@"FMDatabaseQueue could not reopen database for path %@", self.writablePath);
        _database  = nil;
        success = NO;
    }
    
    //为数据库设置缓存，提高查询效率
    [_database setShouldCacheStatements:YES];
    
    return success;
}

- (BOOL)fmdbClose{
    BOOL closed = [_database close];
    _database = nil;
    return closed;
}

- (BOOL)fmdbColumnExists:(NSString*)columnName inTableWithName:(NSString*)tableName {
    return [_database columnExists:columnName inTableWithName:tableName];
}

- (BOOL)fmdbExecuteUpdate:(NSString*)sql parameters:(NSArray*)parameters {
    BOOL isSuccess = [self.database executeUpdate:sql withArgumentsInArray:parameters];
    return isSuccess;
}

- (SNDatabaseResult *)fmdbExecuteQuery:(NSString*)sql parameters:(NSArray*)parameters {
    SNDatabaseResult *result = [[SNDatabaseResult alloc] init];
    FMResultSet *rs = [self.database executeQuery:sql withArgumentsInArray:parameters];
    if(!rs){
        [rs close];
        return result;
    }
    
    int columnCount = [rs columnCount];
    
    //columnNames
    NSMutableArray *columnNames = [[NSMutableArray alloc] init];
    for(int x = 0; x < columnCount; x++) {
        [columnNames addObject:[rs columnNameForIndex:x]];
    }
    result.columnNames = columnNames;
    
    //rows
    NSMutableArray *rows = [[NSMutableArray alloc] init];
    while ([rs next]) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (int i=0; i<columnCount; i++) {
            [data addObject:[rs objectForColumnIndex:i]];
        }
        
        SNDatabaseRow *row = [[SNDatabaseRow alloc] init];
        row.columnNames = result.columnNames;
        row.data = data;
        [rows addObject:row];
    }
    result.rows = rows;
    [rs close];
    
    return result;
}

#pragma mark egodb
//- (BOOL)egoDBexecuteUpdate:(NSString*)sql parameters:(NSArray*)parameters {
//    [self egoDBopenDataBase];
//
//    return [_egoDatabase executeUpdate:sql parameters:parameters];
//}
//
//- (SNDatabaseResult *)egoDBexecuteQuery:(NSString*)sql parameters:(NSArray*)parameters {
//    [self egoDBopenDataBase];
//
//    SNDatabaseResult *result = [[SNDatabaseResult alloc] init];
//
//    EGODatabaseResult *rs = [_egoDatabase executeQuery:sql parameters:parameters];
//
//    //columnNames
//    result.columnNames = rs.columnNames;
//
//    //rows
//    NSMutableArray *rows = [[NSMutableArray alloc] init];
//    for(EGODatabaseRow *rowTmp in rs) {
//        SNDatabaseRow *row = [[SNDatabaseRow alloc] initWithColumnNames:result.columnNames data:rowTmp.data];
//        [rows addObject:row];
//    }
//    result.rows = rows;
//
//    return result;
//}
//
//- (void)egoDBopenDataBase{
//    if ([self isDataBaseOpened]) {
//        return;
//    }
//
//    _egoDatabase = [EGODatabase databaseWithPath:self.writablePath];
//    if (_egoDatabase == 0x00) {
//        _isDataBaseOpened = NO;
//        return;
//    }
//
//    _isDataBaseOpened = YES;
//}
//
//- (void)egoDBClose{
//    if(!_isDataBaseOpened){
//        return;
//    }
//
//    [_egoDatabase close];
//    _isDataBaseOpened = NO;
//}

#pragma mark scsqlite
//- (BOOL)smDBexecuteUpdate:(NSString*)sql parameters:(NSArray*)parameters {
//    [self smDBopenDataBase];
//
//    NSError *error = [_dbManager doUpdateQuery:sql withParams:parameters];
//    if (error != nil) {
//        NSLog(@"Error: %@",[error localizedDescription]);
//        return NO;
//    }
//
//    return YES;
//}
//
//- (SNDatabaseResult *)smDBexecuteQuery:(NSString*)sql parameters:(NSArray*)parameters {
//    [self smDBopenDataBase];
//
//    //需要重新生成sql,to do
//
//    SNDatabaseResult *result = [[SNDatabaseResult alloc] init];
//
//    NSArray *rs = [_dbManager getRowsForQuery:sql];
//    if (rs.count > 0) {
//        //columnNames
//        NSMutableDictionary *dict = [rs firstObject];
//        result.columnNames = dict.allKeys;
//
//        //rows
//        NSMutableArray *rows = [[NSMutableArray alloc] init];
//        for (NSMutableDictionary *dict in rs) {
//            NSMutableArray *data = [[NSMutableArray alloc] init];
//            for (int i=0; i<result.columnNames.count; i++) {
//                NSString *columnName = [result.columnNames objectAtIndex:i];
//                [data addObject:[dict valueForKey:columnName]];
//            }
//            SNDatabaseRow *row = [[SNDatabaseRow alloc] initWithColumnNames:result.columnNames data:data];
//            [rows addObject:row];
//        }
//        result.rows = rows;
//    }
//
//    return result;
//}
//
//- (void)smDBopenDataBase{
//    if ([self isDataBaseOpened]) {
//        return;
//    }
//
//    _dbManager = [[SQLiteManager alloc] initWithDatabaseNamed:self.writablePath];
//    _isDataBaseOpened = YES;
//}
//
//- (void)smDBClose{
//    if(!_isDataBaseOpened){
//        return;
//    }
//
//    [_dbManager close];
//    _isDataBaseOpened = NO;
//}

@end
