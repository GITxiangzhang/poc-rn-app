//
//  SNDatabaseRow.m
//  DBProject
//
//  Created by wangbin on 15/12/1.
//  Copyright © 2015年 wangbin. All rights reserved.
//

#import "SNDatabaseRow.h"

@implementation SNDatabaseRow

- (NSUInteger)indexForName:(NSString *)column {
    return [self.columnNames indexOfObject:column];
}

- (int)intForColumn:(NSString*)column {
    NSUInteger index = [self indexForName:column];
    
    if(index == NSNotFound) {
        return 0;
    } else {
        return [self intForColumnAtIndex:index];
    }
}

- (int)intForColumnAtIndex:(NSUInteger)index {
    return [[self.data objectAtIndex:index] intValue];
}

- (long)longForColumn:(NSString *)column {
    NSUInteger index = [self indexForName:column];
    
    if(index == NSNotFound) {
        return 0;
    } else {
        return [[self.data objectAtIndex:index] longValue];
    }
}

- (long)longForColumnAtIndex:(NSUInteger)index {
    return [[self.data objectAtIndex:index] longValue];
}

- (BOOL)boolForColumn:(NSString *)column {
    return ([self intForColumn:column] != 0);
}

- (BOOL)boolForColumnAtIndex:(NSUInteger)index {
    return ([self intForColumnAtIndex:index] != 0);
}

- (double)doubleForColumn:(NSString *)column {
    NSUInteger index = [self indexForName:column];
    
    if(index == NSNotFound) {
        return 0.0;
    } else {
        return [self doubleForColumnAtIndex:index];
    }
}

- (double)doubleForColumnAtIndex:(NSUInteger)index {
    return [[self.data objectAtIndex:index] doubleValue];
}

- (NSString*)stringForColumn:(NSString *)column {
    NSUInteger index = [self indexForName:column];
    
    if(index == NSNotFound) {
        return nil;
    } else {
        return [self stringForColumnAtIndex:index];
    }
}

- (NSString*)stringForColumnAtIndex:(NSUInteger)index {
    id object = [self.data objectAtIndex:index];
    
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else {
        return [object description];
    }
}

- (NSData*)dataForColumn:(NSString *)column {
    NSUInteger index = [self indexForName:column];
    
    if (index == NSNotFound) {
        return nil;
    } else {
        return [self dataForColumnAtIndex:index];
    }
}

- (NSData*)dataForColumnAtIndex:(NSUInteger)index {
    id object = [self.data objectAtIndex:index];
    
    if ([object isKindOfClass:[NSData class]]) {
        return object;
    } else {
        return nil;
    }
}

- (NSDate*)dateForColumn:(NSString *)column {
    NSUInteger index = [self indexForName:column];
    
    if (index == NSNotFound) {
        return nil;
    } else {
        return [self dateForColumnAtIndex:index];
    }
}

- (NSDate*)dateForColumnAtIndex:(NSUInteger)index {
    return [NSDate dateWithTimeIntervalSince1970:[self doubleForColumnAtIndex:index]];
}

@end
