//
//  SNDatabaseQueue.m
//  DBProject
//
//  Created by wangbin on 15/12/22.
//  Copyright © 2015年 wangbin. All rights reserved.
//

#import "SNDatabaseQueue.h"

@interface SNDatabaseQueue ()

@property(nonatomic, copy) NSString *writablePath;
@property(nonatomic, strong) SNDatabase *database;

@property(nonatomic, strong) dispatch_queue_t queue;

@end

@implementation SNDatabaseQueue

static NSMutableDictionary *databaseDict = nil;
+ (SNDatabaseQueue *)databaseQueueWithPath:(NSString *)path {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        databaseDict = [NSMutableDictionary dictionary];
    });
    
    SNDatabaseQueue *databaseQueue = nil;
    @synchronized(databaseDict) {
        databaseQueue = [databaseDict valueForKey:path];
        if (!databaseQueue) {
            databaseQueue = [[SNDatabaseQueue alloc] initWithPath:path];
            [databaseDict setValue:databaseQueue forKey:path];
        }
    }
    return databaseQueue;
}

- (void)dealloc {
    _queue = nil;
}

- (id)initWithPath:(NSString *)path {
    if (self = [super init]) {
        self.writablePath = path;
        
        _queue = dispatch_queue_create([[NSString stringWithFormat:@"fmdb.%@", self] UTF8String], NULL);
    }
    return self;
}

- (void)inDatabase:(void (^)(SNDatabase *db))block {
    dispatch_sync(_queue, ^{
        if (block) {
            block(self.database);
        }
    });
}

- (void)inTransaction:(void (^)(SNDatabase *db, BOOL *rollback))block {
    dispatch_sync(_queue, ^{
        BOOL shouldRollback = NO;
        [self.database beginTransaction];
        
        block(self.database, &shouldRollback);
        
        if (shouldRollback) {
            [_database rollback];
        } else {
            [_database commit];
        }
    });
}

#pragma mark database
- (SNDatabase *)database {
    if (!_database) {
        _database = [[SNDatabase alloc] initWithPath:self.writablePath];
        BOOL success = [_database open];
        if (!success) {
            _database  = nil;
        }
    }
    
    return _database;
}

@end
