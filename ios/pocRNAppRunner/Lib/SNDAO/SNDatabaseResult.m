//
//  SNDatabaseResult.m
//  DBProject
//
//  Created by wangbin on 15/11/30.
//  Copyright © 2015年 wangbin. All rights reserved.
//

#import "SNDatabaseResult.h"

@implementation SNDatabaseResult

- (SNDatabaseRow *)rowAtIndex:(NSUInteger)index {
    return [self.rows objectAtIndex:index];
}

- (SNDatabaseRow *)firstRow {
    return [self.rows firstObject];
}

- (SNDatabaseRow *)lastRow {
    return [self.rows lastObject];
}

- (NSUInteger)count {
    return [self.rows count];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState*)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len {
    return [self.rows countByEnumeratingWithState:state objects:buffer count:len];
}

@end
