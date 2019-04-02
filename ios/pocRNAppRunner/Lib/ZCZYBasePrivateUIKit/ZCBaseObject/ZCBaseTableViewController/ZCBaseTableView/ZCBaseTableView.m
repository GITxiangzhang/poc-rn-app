//
//  ZCBaseTableView.m
//  ZCZYBasePrivateUIKit
//
//  Created by kipling on 2018/10/22.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import "ZCBaseTableView.h"

#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@implementation ZCBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)ZC_registerCellClass:(Class)cellClass identifier:(NSString *)identifier {
    if (cellClass && identifier.length) {
        [self registerClass:cellClass forCellReuseIdentifier:identifier];
    }
}

- (void)ZC_registerCellNib:(Class)cellNib nibIdentifier:(NSString *)nibIdentifier {
    if (cellNib && nibIdentifier.length) {
        UINib *nib = [UINib nibWithNibName:[cellNib description] bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:nibIdentifier];
    }
}

- (void)ZC_registerHeaderFooterClass:(Class)headerFooterClass identifier:(NSString *)identifier {
    if (headerFooterClass && identifier.length) {
        [self registerClass:headerFooterClass forHeaderFooterViewReuseIdentifier:identifier];
    }
}

- (void)ZC_registerHeaderFooterNib:(Class)headerFooterNib nibIdentifier:(NSString *)nibIdentifier {
    if (headerFooterNib && nibIdentifier.length) {
        UINib *nib = [UINib nibWithNibName:[headerFooterNib description] bundle:nil];
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:nibIdentifier];
    };
}

- (void)ZC_updateWithUpdateBlock:(void (^)(ZCBaseTableView *tableView))updateBlock {
    if (updateBlock) {
        [self beginUpdates];
        updateBlock(self);
        [self endUpdates];
    }
}

- (UITableViewCell *)ZC_cellAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) return nil;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        return nil;
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        return nil;
    }
    return [self cellForRowAtIndexPath:indexPath];
}

- (void)ZC_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self ZC_reloadSingleRowAtIndexPath:indexPath animation:None];
}

- (void)ZC_reloadSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(ZCBaseTableViewRowAnimation)animation {
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
    } else {
        [self beginUpdates];
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

- (void)ZC_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self ZC_reloadRowsAtIndexPaths:indexPaths animation:None];
}

- (void)ZC_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(ZCBaseTableViewRowAnimation)animation {
    if (!indexPaths.count) return ;
    WeakSelf(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf ZC_reloadSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

- (void)ZC_reloadSingleSection:(NSInteger)section {
    [self ZC_reloadSingleSection:section animation:None];
}

- (void)ZC_reloadSingleSection:(NSInteger)section animation:(ZCBaseTableViewRowAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) { // section越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", (long)section, (long)sectionNumber);
    } else {
        [self beginUpdates];
        [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

- (void)ZC_reloadSections:(NSArray <NSNumber *>*)sections {
    [self ZC_reloadSections:sections animation:None];
}

- (void)ZC_reloadSections:(NSArray<NSNumber *> *)sections animation:(ZCBaseTableViewRowAnimation)animation {
    if (!sections.count) return ;
    WeakSelf(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf ZC_reloadSingleSection:obj.integerValue animation:animation];
        }
    }];
}

- (void)ZC_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self ZC_deleteSingleRowAtIndexPath:indexPath animation:Fade];
}

- (void)ZC_deleteSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(ZCBaseTableViewRowAnimation)animation {
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    
    NSLog(@"sectionNumber %ld  section%ld rowNumber%ld",(long)sectionNumber, (long)section , rowNumber);
    if (indexPath.section + 1 > sectionNumber || indexPath.section < 0) { // section 越界
        NSLog(@"删除section: %ld 已经越界, 总组数: %ld", (long)indexPath.section, (long)sectionNumber);
    } else if (indexPath.row + 1 > rowNumber || indexPath.row < 0) { // row 越界
        NSLog(@"删除row: %ld 已经越界, 总行数: %ld 所在section: %ld", (long)indexPath.row, (long)rowNumber, section);
    } else {
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

- (void)ZC_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self ZC_deleteRowsAtIndexPaths:indexPaths animation:Fade];
}

- (void)ZC_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(ZCBaseTableViewRowAnimation)animation {
    if (!indexPaths.count) return ;
    WeakSelf(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf ZC_deleteSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

- (void)ZC_deleteSingleSection:(NSInteger)section {
    
    [self ZC_deleteSingleSection:section animation:Fade];
}

- (void)ZC_deleteSingleSection:(NSInteger)section animation:(ZCBaseTableViewRowAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) { // section 越界
        NSLog(@"刷新section: %ld 已经越界, 总组数: %ld", (long)section, (long)sectionNumber);
    } else {
        [self beginUpdates];
        [self deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

- (void)ZC_deleteSections:(NSArray *)sections {
    [self ZC_deleteSections:sections animation:Fade];
}

- (void)ZC_deleteSections:(NSArray<NSNumber *> *)sections animation:(ZCBaseTableViewRowAnimation)animation {
    if (!sections.count) return ;
    WeakSelf(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf ZC_deleteSingleSection:obj.integerValue animation:animation];
        }
    }];
}

- (void)ZC_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath {
    [self ZC_insertSingleRowAtIndexPath:indexPath animation:None];
}

- (void)ZC_insertSingleRowAtIndexPath:(NSIndexPath *)indexPath animation:(ZCBaseTableViewRowAnimation)animation {
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (section > sectionNumber || section < 0) {
        // section 越界
        NSLog(@"section 越界 : %ld", (long)section);
    } else if (row > rowNumber || row < 0) {
        NSLog(@"row 越界 : %ld", (long)row);
    } else {
        [self beginUpdates];
        [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
    
}

- (void)ZC_insertSingleSection:(NSInteger)section {
    [self ZC_insertSingleSection:section animation:None];
}

- (void)ZC_insertSingleSection:(NSInteger)section animation:(ZCBaseTableViewRowAnimation)animation {
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) {
        // section越界
        NSLog(@" section 越界 : %ld", (long)section);
    } else {
        [self beginUpdates];
        [self insertSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}

- (void)ZC_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self ZC_insertRowsAtIndexPaths:indexPaths animation:None];
}

- (void)ZC_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animation:(ZCBaseTableViewRowAnimation)animation {
    if (indexPaths.count == 0) return ;
    WeakSelf(weakSelf);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf ZC_insertSingleRowAtIndexPath:obj animation:animation];
        }
    }];
}

- (void)ZC_insertSections:(NSArray <NSNumber *>*)sections {
    [self ZC_insertSections:sections animation:None];
}

- (void)ZC_insertSections:(NSArray <NSNumber *>*)sections animation:(ZCBaseTableViewRowAnimation)animation {
    if (sections.count == 0) return ;
    WeakSelf(weakSelf);
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf ZC_insertSingleSection:obj.integerValue animation:animation];
        }
    }];
}

/**
 *  当有输入框的时候 点击tableview空白处，隐藏键盘
 *
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id view = [super hitTest:point withEvent:event];
    if (![view isKindOfClass:[UITextField class]] && ![[view superview] isKindOfClass:[UITextField class]]) {
        [self endEditing:YES];
    }
    return view;
}

@end
