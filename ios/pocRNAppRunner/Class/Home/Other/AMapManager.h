//
//  AMapManager.h
//  PocDemo
//
//  Created by Kipling on 2019/3/26.
//  Copyright © 2019年 Kipling. All rights reserved.
//

#import <Foundation/Foundation.h>
//基础定位类
#import <AMapFoundationKit/AMapFoundationKit.h>
//高德地图基础类
#import <MAMapKit/MAMapKit.h>
//定位
#import <AMapLocationKit/AMapLocationKit.h>
//搜索基础类
#import <AMapSearchKit/AMapSearchKit.h>

@interface AMapManager : NSObject

//选择的经纬度
@property (nonatomic ,copy) AMapGeoPoint *aMapLocation;

//初始化单例管理员对象
+(instancetype)sharedManager;
//开始定位
- (void)startSinglelLocationRequestLocationWithReGeocode:(BOOL)reGeocode completionBlock:(void (^)(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error))completionBlock;

@end

