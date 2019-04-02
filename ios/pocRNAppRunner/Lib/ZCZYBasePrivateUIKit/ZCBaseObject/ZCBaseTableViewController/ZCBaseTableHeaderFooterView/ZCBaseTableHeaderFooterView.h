//
//  ZCBaseTableHeaderFooterView.h
//  ZCZYBasePrivateUIKit
//
//  Created by kipling on 2018/10/22.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCBaseTableHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, weak)id delegate;

/**
 配置页面
 
 @param data 数据
 */
- (void)fillData:(id)data;

/**
 计算cell高度
 
 @param data 数据
 @return cell高度
 */
+ (CGFloat)computeHeight:(id)data;

/**
 获取复用Identifier
 
 @return Identifier
 */
+ (NSString *)getReuserIdentifer;

/**
 *  快速创建一个不是从xib中加载的tableview header footer
 */
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView;

/**
 *  快速创建一个从xib中加载的tableview header footer
 */
+ (instancetype)nibHeaderFooterViewWithTableView:(UITableView *)tableView;

@end
