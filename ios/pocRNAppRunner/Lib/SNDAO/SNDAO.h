//
//  SNDAO.h
//  DBProject
//
//  Created by wangbin on 15/12/17.
//  Copyright © 2015年 wangbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNDatabaseQueue.h"

@interface SNDAO : NSObject

//1.0.1 check
@property(nonatomic, strong) SNDatabaseQueue *databaseQueue;

//返回默认操作数据库的路径
//需要重写
- (NSString *)databasePath;

//创建整个模块需要的表，app生命周期只执行一次
//需要重写
- (void)createaAllTablesOnce;

//返回默认操作数据库的key
//需要重写
- (NSString *)dataBaseKey;

@end
