//
//  AMapManager.m
//  PocDemo
//
//  Created by Kipling on 2019/3/26.
//  Copyright © 2019年 Kipling. All rights reserved.
//

#import "AMapManager.h"

@interface AMapManager ()<AMapLocationManagerDelegate,AMapSearchDelegate>

//定位管理
@property (nonatomic, strong) AMapLocationManager *locationManager;
//一个search对象，用于地理位置逆编码
@property(nonatomic,strong)AMapSearchAPI *search;

@end

@implementation AMapManager

#pragma mark --创建一个单例类对象
+ (instancetype)sharedManager{
    static AMapManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //初始化单例对象
        instance = [[AMapManager alloc]init];
    });
    return instance;
}

/** 定位Manager */
- (AMapLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        [_locationManager setLocationTimeout:2];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

#pragma mark serach初始化
- (AMapSearchAPI *)search {
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}

#pragma mark - 开始定位 -
- (void)startSinglelLocationRequestLocationWithReGeocode:(BOOL)reGeocode completionBlock:(void (^)(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error))completionBlock {
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        completionBlock(location,regeocode,error);
    }];
}


@end
