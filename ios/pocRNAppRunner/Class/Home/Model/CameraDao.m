//
//  CameraDao.m
//  Runner
//
//  Created by Kipling on 2019/3/30.
//  Copyright © 2019年 The Chromium Authors. All rights reserved.
//

#import "CameraDao.h"

@implementation CameraDao

- (id)init {
    if (self = [super init]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self createaAllTablesOnce];
        });
    }
    return self;
}

#pragma mark database
- (NSString *)databasePath {
    
    //数据库文件
    NSString *docpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbDirectory = [docpath stringByAppendingPathComponent:@"PocDemo_Flutter"];
    dbDirectory = [dbDirectory stringByAppendingPathComponent:@"Database"];
    NSString *dbPath = [dbDirectory stringByAppendingString:@"/camera.sqlite"];
    
    //数据库目录
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:dbDirectory isDirectory:&isDir];
    if (!(isExist&&isDir))  {
        [fileManager createDirectoryAtPath:dbDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    return dbPath;
}

- (void)createaAllTablesOnce {
    
    [self.databaseQueue inDatabase:^(SNDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS camera_image (image_id integer PRIMARY KEY AUTOINCREMENT, image_name text NOT NULL, image_data BLOB NOT NULL)"];
        BOOL ret = [db executeUpdate:sql parameters:nil];
        if (!ret) {
            NSLog(@"table camera_image create failed!");
        }
    }];
}

- (void)insertDatabaseWithImage:(UIImage *)image {
    
    [self.databaseQueue inDatabase:^(SNDatabase *db) {
        
        NSString *sp = [[self dateConversionTimeStamp:[NSDate date]] stringByAppendingString:@".png"];
        NSData *data = UIImagePNGRepresentation(image);
        NSString *sql = [NSString stringWithFormat:@"insert into camera_image (image_name,image_data) values(?,?)"];
        NSArray *parameters = [NSArray arrayWithObjects:sp, data,nil];

        BOOL ret = [db executeUpdate:sql parameters:parameters];
        if (!ret) {
            NSLog(@"插入失败");
        }
    }];
}

- (NSString *)dateConversionTimeStamp:(NSDate *)date {
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    return timeSp;
}

- (NSArray *)getCameraImageData {
    
    __block NSMutableArray *arrayM = [NSMutableArray array];
    [self.databaseQueue inDatabase:^(SNDatabase *db) {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM camera_image"];
        SNDatabaseResult *result = [db executeQuery:sql parameters:nil];
        if (result.rows.count > 0) {
            
            [result.rows enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSData *data = [(SNDatabaseRow *)obj dataForColumn:@"image_data"];
                [arrayM addObject:data];
            }];
        }
    }];
    return [arrayM copy];
}

@end
