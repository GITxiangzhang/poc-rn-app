//
//  ZCBaseTableViewController.h
//  ZCZYBasePrivateUIKit
//
//  Created by kipling on 2018/10/22.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import "ZCBaseViewController.h"
#import "ZCBaseTableViewCell.h"
#import "ZCBaseTableView.h"

typedef NS_ENUM(NSUInteger, ZCBaseTableViewType) {
    //默认 plain
    ZCBaseTableViewTypeNormal = 0,
    //plain
    ZCBaseTableViewTypePlain,
    //group
    ZCBaseTableViewTypeGroup,
};

@interface ZCBaseTableViewController : ZCBaseViewController <UITableViewDelegate, UITableViewDataSource>

/**
 *  设置tableview的类型 plain/group
 */
@property (nonatomic, assign) ZCBaseTableViewType tableViewType;

/**
 *  隐藏statusBar
 */
@property (nonatomic, assign) BOOL hiddenStatusBar;

/**
 *  statusBar风格
 */
@property (nonatomic, assign) UIStatusBarStyle barStyle;

/**
 *  表视图
 */
@property (nonatomic, strong) ZCBaseTableView *tableView;

/**
 *  表视图偏移
 */
@property (nonatomic, assign) UIEdgeInsets tableEdgeInset;

/**
 *  分割线颜色
 */
@property (nonatomic, assign) UIColor *sepLineColor;

/**
 *  是否需要系统的cell的分割线
 */
@property (nonatomic, assign) BOOL needCellSepLine;

/**
 *  刷新数据
 */
- (void)ZC_reloadData;

#pragma mark - 子类去重写
/**
 *  分组数量
 *
 *  @return return value description
 */
- (NSInteger)ZC_numberOfSections;

/**
 *  某个分组的cell数量
 */
- (NSInteger)ZC_numberOfRowsInSection:(NSInteger)section;

/**
 *  某行的cell
 */
- (ZCBaseTableViewCell *)ZC_cellAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  点击某行
 */
- (void)ZC_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(ZCBaseTableViewCell *)cell;

/**
 *  行高
 */
- (CGFloat)ZC_cellheightAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  某个组头
 */
- (UIView *)ZC_headerAtSection:(NSInteger)section;

/**
 *  某个组bottom视图
 */
- (UIView *)ZC_footerAtSection:(NSInteger)section;

/**
 *  某个组头高度
 */
- (CGFloat)ZC_sectionHeaderHeightAtSection:(NSInteger)section;

/**
 *  某个组尾高度
 */
- (CGFloat)ZC_sectionFooterHeightAtSection:(NSInteger)section;

/**
 *  侧边栏数组
 */
- (NSArray *)ZC_sectionIndexTitles;

/**
 *  索引
 */
- (NSString *)ZC_titleForHeaderInSection:(NSInteger)section;

/**
 *  索引
 */
- (NSInteger)ZC_sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

/**
 *  分割线偏移
 */
- (UIEdgeInsets)ZC_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  自定义侧滑删除标题
 */
-(NSString *)ZC_titleForDeleteAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  自定义侧滑操作开关
 */
- (BOOL)ZC_canEditActionForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  侧滑点击响应时间
 */
- (void)ZC_commitEditActionWithStyle:(UITableViewCellEditingStyle)style atIndexPath:(NSIndexPath *)indexPath;

/**
 *  cell即将显示
 */
- (void)ZC_cellWillDisplay:(ZCBaseTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
