//
//  ZCBaseTableView.h
//  ZCZYBasePrivateUIKit
//
//  Created by kipling on 2018/10/22.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZCBaseTableViewRowAnimation) {
    Fade = UITableViewRowAnimationFade,
    Right = UITableViewRowAnimationRight,           // slide in from right (or out to right)
    Left = UITableViewRowAnimationLeft,
    Top = UITableViewRowAnimationTop,
    Bottom = UITableViewRowAnimationBottom,
    None = UITableViewRowAnimationNone,            // available in iOS 3.0
    Middle = UITableViewRowAnimationMiddle,          // available in iOS 3.2.  attempts to keep cell centered in the space it will/did occupy
    Automatic = 100  // available in iOS 5.0.  chooses an appropriate animation style for you
};

@class ZCBaseTableViewCell;

@interface ZCBaseTableView : UITableView

- (void)ZC_updateWithUpdateBlock:(void(^)(ZCBaseTableView *tableView ))updateBlock;

- (UITableViewCell *)ZC_cellAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  注册普通的UITableViewCell
 *
 *  @param cellClass  Class
 *  @param identifier 复用标示
 */
- (void)ZC_registerCellClass:(Class)cellClass identifier:(NSString *)identifier;

/**
 *  注册一个从xib中加载的UITableViewCell
 *
 *  @param cellNib       nib
 *  @param nibIdentifier 复用标示
 */
- (void)ZC_registerCellNib:(Class)cellNib nibIdentifier:(NSString *)nibIdentifier;

/**
 *  注册一个普通的UITableViewHeaderFooterView
 *
 *  @param headerFooterClass Class
 *  @param identifier        复用标示
 */
- (void)ZC_registerHeaderFooterClass:(Class)headerFooterClass identifier:(NSString *)identifier;

/**
 *  注册一个从xib中加载的UITableViewHeaderFooterView
 *
 *  @param headerFooterNib nib
 *  @param nibIdentifier   复用标示
 */
- (void)ZC_registerHeaderFooterNib:(Class)headerFooterNib nibIdentifier:(NSString *)nibIdentifier;

#pragma mark - 只对已经存在的cell进行刷新
/**
 *  刷新单行
 *
 *  @param indexPath 坐标
 */
- (void)ZC_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  刷新单行
 *
 *  @param indexPath 坐标
 *  @param animation 动画类型
 */
- (void)ZC_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(ZCBaseTableViewRowAnimation)animation;

/**
 *  刷新多行
 *
 *  @param indexPaths 坐标
 */
- (void)ZC_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/**
 *  刷新多行
 *
 *  @param indexPaths 坐标
 *  @param animation  动画类型
 */
- (void)ZC_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(ZCBaseTableViewRowAnimation)animation;

/**
 *  刷新某个section
 *
 *  @param section 分组坐标
 */
- (void)ZC_reloadSingleSection:(NSInteger)section;

/**
 *  刷新某个section
 *
 *  @param section   分组坐标
 *  @param animation 动画类型
 */
- (void)ZC_reloadSingleSection:(NSInteger)section animation:(ZCBaseTableViewRowAnimation)animation;

/**
 *  刷新多个section
 *
 *  @param sections 坐标
 */
- (void)ZC_reloadSections:(NSArray <NSNumber *>*)sections;

/**
 *  刷新多个section
 *
 *  @param sections  分组坐标
 *  @param animation 动画类型
 */
- (void)ZC_reloadSections:(NSArray <NSNumber *>*)sections animation:(ZCBaseTableViewRowAnimation)animation;

#pragma mark - 对cell进行删除操作
/**
 *  删除单行
 *
 *  @param indexPath 坐标
 */
- (void)ZC_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  删除单行
 *
 *  @param indexPath 坐标
 *  @param animation 动画类型
 */
- (void)ZC_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(ZCBaseTableViewRowAnimation)animation;

/**
 *  删除多行
 *
 *  @param indexPaths 坐标
 */
- (void)ZC_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/**
 *  删除多行
 *
 *  @param indexPaths 坐标
 *  @param animation  动画类型
 */
- (void)ZC_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(ZCBaseTableViewRowAnimation)animation;

/**
 *  删除某个section
 *
 *  @param section 坐标
 */
- (void)ZC_deleteSingleSection:(NSInteger)section;

/**
 *  删除某个section
 *
 *  @param section   坐标
 *  @param animation 动画类型
 */
- (void)ZC_deleteSingleSection:(NSInteger)section animation:(ZCBaseTableViewRowAnimation)animation;

/**
 *  删除多个section
 *
 *  @param sections 坐标
 */
- (void)ZC_deleteSections:(NSArray <NSNumber *>*)sections;

/**
 *  删除多个section
 *
 *  @param sections  坐标
 *  @param animation 动画类型
 */
- (void)ZC_deleteSections:(NSArray <NSNumber *>*)sections animation:(ZCBaseTableViewRowAnimation)animation;

#pragma mark - 插入cell
/**
 *  增加单行
 *
 *  @param indexPath 坐标
 */
- (void)ZC_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  增加单行
 *
 *  @param indexPath 坐标
 *  @param animation 动画类型
 */
- (void)ZC_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(ZCBaseTableViewRowAnimation)animation;

/**
 *  增加单个section
 *
 *  @param section 坐标
 */
- (void)ZC_insertSingleSection:(NSInteger)section;

/**
 *  增加单个section
 *
 *  @param section   坐标
 *  @param animation 动画类型
 */
- (void)ZC_insertSingleSection:(NSInteger)section animation:(ZCBaseTableViewRowAnimation)animation;

/**
 *  增加多行
 *
 *  @param indexPaths 坐标
 */
- (void)ZC_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/**
 *  增加多行
 *
 *  @param indexPaths 坐标
 *  @param animation  动画类型
 */
- (void)ZC_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(ZCBaseTableViewRowAnimation)animation;

/**
 *  增加多section
 *
 *  @param sections 坐标
 */
- (void)ZC_insertSections:(NSArray <NSNumber *>*)sections;

/**
 *  增加多section
 *
 *  @param sections  坐标
 *  @param animation 动画类型
 */
- (void)ZC_insertSections:(NSArray <NSNumber *>*)sections animation:(ZCBaseTableViewRowAnimation)animation;


@end
