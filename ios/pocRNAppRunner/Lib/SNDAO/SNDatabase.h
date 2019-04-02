//
//  SNDatabase.h
//  DBProject
//
//  Created by wangbin on 15/12/17.
//  Copyright © 2015年 wangbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNDatabaseResult.h"

@interface SNDatabase : NSObject

- (id)initWithPath:(NSString *)path;

- (BOOL)open;

- (BOOL)close;

- (BOOL)columnExists:(NSString*)columnName inTableWithName:(NSString*)tableName;

- (BOOL)executeUpdate:(NSString*)sql parameters:(NSArray*)parameters;

- (SNDatabaseResult *)executeQuery:(NSString*)sql parameters:(NSArray*)parameters;

- (BOOL)beginTransaction;

- (BOOL)commit;

- (BOOL)rollback;

@end
