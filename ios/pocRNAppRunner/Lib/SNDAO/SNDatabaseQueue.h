//
//  SNDatabaseQueue.h
//  DBProject
//
//  Created by wangbin on 15/12/22.
//  Copyright © 2015年 wangbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNDatabase.h"

@interface SNDatabaseQueue : NSObject

+ (SNDatabaseQueue *)databaseQueueWithPath:(NSString *)path;

- (void)inDatabase:(void (^)(SNDatabase *db))block;

- (void)inTransaction:(void (^)(SNDatabase *db, BOOL *rollback))block;

@end
