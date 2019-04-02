//
//  MapViewController.m
//  PocDemo
//
//  Created by Kipling on 2019/3/26.
//  Copyright © 2019年 Kipling. All rights reserved.
//

#import "MapViewController.h"
#import "BaseServerConfig.h"
#import <Masonry/Masonry.h>

#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "AMapManager.h"

@interface MapViewController ()<MAMapViewDelegate,AMapSearchDelegate>

//地址
@property (nonatomic, strong) UILabel *locationLb;
//标题
@property (nonatomic, strong) UILabel *titlelocLb;
//显示的地图
@property (nonatomic, strong) MAMapView *mapView;
//选择的经纬度
@property (nonatomic ,copy) AMapGeoPoint *aMapLocation;
//搜索
@property (nonatomic, strong) AMapSearchAPI *search;

@end

@implementation MapViewController

- (void)dealloc {
    [_mapView.layer removeAnimationForKey:@"aAlpha"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"map";
    [self initializeUI];
}

#pragma mark -- UI --
- (void)initializeUI {
    
    [self createTopView];
    [self initMap];
    [self addWidgetToMap];
    [self startSinglelLocation];
}

- (void)createTopView {
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.masksToBounds = YES;
    topView.layer.cornerRadius = 6.f;
    
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.text = @"get targeting";
    titleLb.textColor = kHexColor(0x4A8CEF);
    titleLb.font = [UIFont boldSystemFontOfSize:17.f];
    self.titlelocLb = titleLb;
    
    self.locationLb = [[UILabel alloc] init];
    self.locationLb.textAlignment = NSTextAlignmentCenter;
    self.locationLb.text = @"positioning...";
    self.locationLb.textColor = kHexColor(0x333333);
    self.locationLb.font = [UIFont systemFontOfSize:15.f];
    
    [self.view addSubview:topView];
    [topView addSubview:titleLb];
    [topView addSubview:self.locationLb];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kNavigationBarHeight + 10);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.mas_equalTo(80);
    }];

    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(18);
        make.right.left.offset(0);
        make.height.mas_equalTo(20);
    }];
    
    [self.locationLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(titleLb.mas_bottom).offset(8);
    }];
}

/** 地图Manager */
- (void)initMap {
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(10, kNavigationBarHeight+100, kScreenWidth-20, kScreenHeight-110-kNavigationBarHeight)];
    self.mapView.showsUserLocation = YES;
    self.mapView.showsScale = NO;
    self.mapView.showsCompass = NO;
    self.mapView.delegate = self;
    self.mapView.layer.masksToBounds = YES;
    self.mapView.layer.cornerRadius = 6.f;
    [self.view addSubview:self.mapView];
}

/** 添加控件到地图 */
- (void)addWidgetToMap {
    
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:@"icn_home_map"];
    [self.mapView addSubview:image];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mapView);
        make.bottom.equalTo(self.mapView.mas_centerY).offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

#pragma mark -- lazy load --
- (AMapSearchAPI *)search {
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}

#pragma mark - 点击事件 -
- (void)startSinglelLocation {
    
    __weak typeof(self)weakSelf = self;
    [[AMapManager sharedManager] startSinglelLocationRequestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        __strong typeof(self)strongSelf = weakSelf;
        NSLog(@"错误码 ==== %@",error);
        if (error) {
            if (error.code == 5) {}else{
            }
        }else{
            //获取到定位信息，更新中心
            strongSelf.aMapLocation = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
            [strongSelf startLocationWithCcoordinate];
        }
    }];
}

#pragma mark -- MAMapViewDelegate --
/** 获取到定位信息，更新中心 */
- (void)startLocationWithCcoordinate {
    
    [self.mapView setZoomLevel:12.6 animated:YES];
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(self.aMapLocation.latitude, self.aMapLocation.longitude)];
    [self loadAnnotationData];
}

- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction {
    if (wasUserAction) {
        self.locationLb.text = @"positioning...";
    }
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    if (wasUserAction) {
        self.aMapLocation = [AMapGeoPoint locationWithLatitude:self.mapView.centerCoordinate.latitude longitude:self.mapView.centerCoordinate.longitude];
        [self loadAnnotationData];
    }
}

#pragma mark -- private --
- (void)loadAnnotationData {
    
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.location = self.aMapLocation;
    regeoRequest.radius = 1000;
    regeoRequest.requireExtension = YES;
    
    //发起逆地理编码
    [self.search AMapReGoecodeSearch: regeoRequest];
}

#pragma mark -- AMapSearchDelegate --
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    
    if(response.regeocode != nil) {
        self.locationLb.text = response.regeocode.formattedAddress;
    }else {
        self.locationLb.text = @"定位失败";
    }
}

@end
