//
//  SNDatabaseResult.h
//  DBProject
//
//  Created by wangbin on 15/11/30.
//  Copyright © 2015年 wangbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNDatabaseRow.h"

@interface SNDatabaseResult : NSObject<NSFastEnumeration>

@property(nonatomic, strong) NSArray *columnNames;
@property(nonatomic, strong) NSArray *rows;

- (SNDatabaseRow *)rowAtIndex:(NSUInteger)index;
- (NSUInteger)count;

- (SNDatabaseRow *)firstRow;
- (SNDatabaseRow *)lastRow;

@end
