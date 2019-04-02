//
//  SNDAO.m
//  DBProject
//
//  Created by wangbin on 15/12/17.
//  Copyright © 2015年 wangbin. All rights reserved.
//

#import "SNDAO.h"

@interface SNDAO ()


@end

@implementation SNDAO

//子工程需要自行复制实现init，继承的话无论多少子类，dispatch_once只会执行一次
//- (id)init {
//    if (self = [super init]) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            [self createaAllTablesOnce];
//        });
//    }
//    return self;
//}

- (NSString *)databasePath {
    return @"";
}

- (NSString *)dataBaseKey {
    return @"";
}

- (void)createaAllTablesOnce {
    
}

#pragma mark property
- (SNDatabaseQueue *)databaseQueue {
    if (!_databaseQueue) {
        _databaseQueue = [SNDatabaseQueue databaseQueueWithPath:[self databasePath]];
    }
    return _databaseQueue;
}

@end
