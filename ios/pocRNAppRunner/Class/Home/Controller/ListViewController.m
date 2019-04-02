//
//  ListViewController.m
//  PocDemo
//
//  Created by Kipling on 2019/3/22.
//  Copyright © 2019年 Kipling. All rights reserved.
//

#import "ListViewController.h"
#import "BaseServerConfig.h"
#import "ListViewCell.h"

#import "MapViewController.h"
#import "CameraViewController.h"
#import "NativeAlertView.h"
#import "CameraListController.h"

#import "ReactNativeContainerVC.h"

@interface ListViewController ()

//背景
@property (nonatomic, strong) UIView *backTopView;
//数据源
@property (nonatomic, strong) NSMutableArray <NSDictionary *>*dataArrM;
//弹出框
@property (nonatomic, strong) NativeAlertView *alertView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Native List Page";
    self.navBar.backButton.hidden = YES;
    self.navBar.bottomLine.hidden = YES;
    [self initializeUI];
}

#pragma mark -- UI --
- (void)initializeUI {
    
    self.tableViewType = ZCBaseTableViewTypeGroup;
    self.needCellSepLine = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UIView *tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"ListViewTableViewHeader" owner:nil options:nil].firstObject;
    tableHeaderView.frame = CGRectMake(0, 0, kScreenWidth, 136);
    self.tableView.tableHeaderView = tableHeaderView;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate> --
- (NSInteger)ZC_numberOfSections {
    return self.dataArrM.count;
}

- (NSInteger)ZC_numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)ZC_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 88.f;
}

- (ZCBaseTableViewCell *)ZC_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dataDic = self.dataArrM[indexPath.section];
    ListViewCell *cell = [ListViewCell nibCellWithTableView:self.tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataDic = dataDic;
    return cell;
}

- (CGFloat)ZC_sectionHeaderHeightAtSection:(NSInteger)section {
    return 7;
}

- (UIView *)ZC_headerAtSection:(NSInteger)section {
    return [UIView new];
}

- (void)ZC_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(ZCBaseTableViewCell *)cell {
    
    switch (indexPath.section) {
        case 0:{
            //Web
            ReactNativeContainerVC *vc = [[ReactNativeContainerVC alloc] init];
            [self pushVc:vc];
//            [self.alertView showActionPopView];
        }
            break;
        case 1:{
            //地图
            MapViewController *vc = [[MapViewController alloc] init];
            [self pushVc:vc];
        }
            break;
        case 2:{
            //camera
            CameraListController *vc = [[CameraListController alloc] init];
            [self pushVc:vc];
        }
            break;
        case 3:{
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- lazy load --
- (NSMutableArray <NSDictionary *>*)dataArrM {
    if (!_dataArrM) {
        _dataArrM = [NSMutableArray arrayWithArray:@[
  @{@"image":@"icon_home_web",@"title":@"go to web view",@"subtitle":@"from native page to web page"},
  @{@"image":@"icn_home_map",@"title":@"map",@"subtitle":@"get targeting"},
  @{@"image":@"icon_home_camera",@"title":@"camera",@"subtitle":@"wake up the camera"},
  @{@"image":@"icon_home_stroe",@"title":@"Varivables",@"subtitle":@"STORE IT"}
  ]];
}
    return _dataArrM;
}

- (NativeAlertView *)alertView {
    if (!_alertView) {
        _alertView = [[NSBundle mainBundle] loadNibNamed:@"NativeAlertView" owner:nil options:nil].firstObject;
        _alertView.frame = CGRectMake(0, 0, 300, 180);
    }
    return _alertView;
}

@end
