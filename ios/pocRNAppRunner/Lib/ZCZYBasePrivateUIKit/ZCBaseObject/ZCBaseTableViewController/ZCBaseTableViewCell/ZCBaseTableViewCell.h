//
//  ZCBaseTableViewCell.h
//  ZCZYBasePrivateUIKit
//
//  Created by kipling on 2018/10/22.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCBaseTableViewCell : UITableViewCell

/**
 *  返回持有该cell的tableview
 */
@property (nonatomic, weak) UITableView *tableView;

/**
 *  快速创建一个不是从xib中加载的tableview cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  快速创建一个从xib中加载的tableview cell
 */
+ (instancetype)nibCellWithTableView:(UITableView *)tableView;

/**
 *  获取cell的复用ID
 *
 *  @return r
 */
+ (NSString *)getCellReuserIdentifer;

@end
