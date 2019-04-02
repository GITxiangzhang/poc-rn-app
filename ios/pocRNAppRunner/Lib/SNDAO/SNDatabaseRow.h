//
//  SNDatabaseRow.h
//  DBProject
//
//  Created by wangbin on 15/12/1.
//  Copyright © 2015年 wangbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNDatabaseRow : NSObject

@property(nonatomic, strong) NSArray *columnNames;
@property(nonatomic, strong) NSArray *data;

- (int)intForColumn:(NSString *)name;
- (int)intForColumnAtIndex:(NSUInteger)index;

- (long)longForColumn:(NSString *)name;
- (long)longForColumnAtIndex:(NSUInteger)index;

- (BOOL)boolForColumn:(NSString *)name;
- (BOOL)boolForColumnAtIndex:(NSUInteger)index;

- (double)doubleForColumn:(NSString *)name;
- (double)doubleForColumnAtIndex:(NSUInteger)index;

- (NSString*)stringForColumn:(NSString *)name;
- (NSString*)stringForColumnAtIndex:(NSUInteger)index;

- (NSData*)dataForColumn:(NSString *)name;
- (NSData*)dataForColumnAtIndex:(NSUInteger)index;

- (NSDate*)dateForColumn:(NSString *)name;
- (NSDate*)dateForColumnAtIndex:(NSUInteger)index;

@end
