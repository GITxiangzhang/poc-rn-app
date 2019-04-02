//
//  ZCBaseTableViewController.m
//  ZCZYBasePrivateUIKit
//
//  Created by kipling on 2018/10/22.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import "ZCBaseTableViewController.h"
#import "ZCBaseTableViewCell.h"
#import "ZCBaseTableHeaderFooterView.h"
#import <objc/runtime.h>
//#import "UIView+Tap.h"

#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define kSeperatorColor [UIColor colorWithRed:0.918 green:0.929 blue:0.941 alpha:1.000]
#define kTableviewBackgroundColor [UIColor colorWithRed:239/255.f green:240/255.f blue:243/255.f alpha:1.000]

#define kWhiteColor [UIColor whiteColor]

@interface ZCBaseTableViewController ()

@end

@implementation ZCBaseTableViewController

@synthesize needCellSepLine = _needCellSepLine;
@synthesize sepLineColor = _sepLineColor;
@synthesize hiddenStatusBar = _hiddenStatusBar;
@synthesize barStyle = _barStyle;

/**
 *  加载tableview
 */
- (ZCBaseTableView *)tableView {
    if(!_tableView){
        UITableViewStyle style = UITableViewStylePlain;
        
        if (self.tableViewType == ZCBaseTableViewTypeGroup) {
            style = UITableViewStyleGrouped;
        }
        
        CGFloat originY = 0;
        originY =  self.navBar.isHidden ? 0 : [[UIApplication sharedApplication] statusBarFrame].size.height + 44;
        _tableView = [[ZCBaseTableView alloc] initWithFrame:CGRectMake(0, originY, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - originY) style:style];
        [self.view addSubview:_tableView];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kTableviewBackgroundColor;
        _tableView.separatorColor = kSeperatorColor;
        
        //ios11以后，系统自动开启Self-Sizing属性，会导致cell高度重新计算，reloaddata的时候会造成错位
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

/** statusBar是否隐藏*/
- (void)setHiddenStatusBar:(BOOL)hiddenStatusBar {
    _hiddenStatusBar = hiddenStatusBar;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)hiddenStatusBar {
    return _hiddenStatusBar;
}

- (void)setBarStyle:(UIStatusBarStyle)barStyle {
    if (_barStyle == barStyle) return ;
    _barStyle = barStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)prefersStatusBarHidden {
    return self.hiddenStatusBar;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.barStyle;
}

/** 需要系统分割线*/
- (void)setNeedCellSepLine:(BOOL)needCellSepLine {
    _needCellSepLine = needCellSepLine;
    self.tableView.separatorStyle = needCellSepLine ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
}

- (BOOL)needCellSepLine {
    return self.tableView.separatorStyle == UITableViewCellSeparatorStyleSingleLine;
}

/** 表视图偏移*/
- (void)setTableEdgeInset:(UIEdgeInsets)tableEdgeInset {
    _tableEdgeInset = tableEdgeInset;
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [self.view layoutIfNeeded];
    [self.view setNeedsLayout];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.tableView.contentInset = self.tableEdgeInset;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    self.tableView.frame = self.view.bounds;
    [self.view sendSubviewToBack:self.tableView];
}
/** 分割线颜色*/
- (void)setSepLineColor:(UIColor *)sepLineColor {
    if (!self.needCellSepLine) return;
    _sepLineColor = sepLineColor;
    
    if (sepLineColor) {
        self.tableView.separatorColor = sepLineColor;
    }
}

- (UIColor *)sepLineColor {
    return _sepLineColor ? _sepLineColor : [UIColor whiteColor];
}

/** 刷新数据*/
- (void)ZC_reloadData {
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
// 分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(ZC_numberOfSections)]) {
        return self.ZC_numberOfSections;
    }
    return 0;
}

// 指定组返回的cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(ZC_numberOfRowsInSection:)]) {
        return [self ZC_numberOfRowsInSection:section];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(ZC_headerAtSection:)]) {
        return [self ZC_headerAtSection:section];
    }
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(ZC_footerAtSection:)]) {
        return [self ZC_footerAtSection:section];
    }
    return [[UIView alloc] init];
}

// 每一行返回指定的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self respondsToSelector:@selector(ZC_cellAtIndexPath:)]) {
        return [self ZC_cellAtIndexPath:indexPath];
    }
    // 1. 创建cell
    ZCBaseTableViewCell *cell = [ZCBaseTableViewCell cellWithTableView:self.tableView];
    // 2. 返回cell
    return cell;
}

// 点击某一行 触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZCBaseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self respondsToSelector:@selector(ZC_didSelectCellAtIndexPath:cell:)]) {
        [self ZC_didSelectCellAtIndexPath:indexPath cell:cell];
    }
}

// 设置分割线偏移间距并适配
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.needCellSepLine) return ;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    if ([self respondsToSelector:@selector(ZC_sepEdgeInsetsAtIndexPath:)]) {
        edgeInsets = [self ZC_sepEdgeInsetsAtIndexPath:indexPath];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) [tableView setSeparatorInset:edgeInsets];
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) [tableView setLayoutMargins:edgeInsets];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) [cell setSeparatorInset:edgeInsets];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) [cell setLayoutMargins:edgeInsets];
    
    if ([self respondsToSelector:@selector(ZC_cellWillDisplay:forRowAtIndexPath:)]) {
        [self ZC_cellWillDisplay:(ZCBaseTableViewCell *)cell forRowAtIndexPath:indexPath];
    }
}

// 每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(ZC_cellheightAtIndexPath:)]) {
        return [self ZC_cellheightAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(ZC_sectionHeaderHeightAtSection:)]) {
        return [self ZC_sectionHeaderHeightAtSection:section];
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(ZC_sectionFooterHeightAtSection:)]) {
        return [self ZC_sectionFooterHeightAtSection:section];
    }
    return 0.01;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(ZC_sectionIndexTitles)]) {
        return [self ZC_sectionIndexTitles];
    }
    return @[];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(ZC_titleForHeaderInSection:)]) {
        return [self ZC_titleForHeaderInSection:section];
    }
    return @"";
    
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if ([self respondsToSelector:@selector(ZC_sectionForSectionIndexTitle:atIndex:)]) {
        return [self ZC_sectionForSectionIndexTitle:title atIndex:index];
    }
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(ZC_canEditActionForRowAtIndexPath:)]) {
        return [self ZC_canEditActionForRowAtIndexPath:indexPath];
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(ZC_commitEditActionWithStyle:atIndexPath:)]) {
        [self ZC_commitEditActionWithStyle:editingStyle atIndexPath:indexPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(ZC_titleForDeleteAtIndexPath:)]) {
        return [self ZC_titleForDeleteAtIndexPath:indexPath];
    }
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSInteger)ZC_numberOfSections {
    return 1;
}

- (NSInteger)ZC_numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)ZC_cellAtIndexPath:(NSIndexPath *)indexPath {
    return [ZCBaseTableViewCell cellWithTableView:self.tableView];
}

- (CGFloat)ZC_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)ZC_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(ZCBaseTableViewCell *)cell {
}

- (UIView *)ZC_headerAtSection:(NSInteger)section {
    return [ZCBaseTableHeaderFooterView headerFooterViewWithTableView:self.tableView];
}

- (UIView *)ZC_footerAtSection:(NSInteger)section {
    return [ZCBaseTableHeaderFooterView headerFooterViewWithTableView:self.tableView];
}

- (CGFloat)ZC_sectionHeaderHeightAtSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)ZC_sectionFooterHeightAtSection:(NSInteger)section {
    return 0.01;
}

- (UIEdgeInsets)ZC_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(0, 15, 0, 0);
}

- (NSArray *)ZC_sectionIndexTitles {
    return @[];
}

- (NSString *)ZC_titleForHeaderInSection:(NSInteger)section {
    return @"";
}

- (NSInteger)ZC_sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 0;
}

- (NSArray<UITableViewRowAction *> *)ZC_editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @[];
}

- (BOOL)ZC_canEditActionForRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(NSString *)ZC_titleForDeleteAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)ZC_commitEditActionWithStyle:(UITableViewCellEditingStyle)style atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)ZC_cellWillDisplay:(ZCBaseTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
