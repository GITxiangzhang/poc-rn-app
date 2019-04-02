//
//  ZCBaseNavigationBar.h
//  IndividualCenter
//
//  Created by kipling on 2018/10/29.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NavImageType_Back_White,           // 返回 白色
    NavImageType_Back_Gray,            // 返回 灰色
    NavImageType_Share_Gray,           // 分享
    NavImageType_Share_Circle,
    NavImageType_More_White,           // 更多
    NavImageType_More_Gray,
    NavImageType_More_Circle,
    NavImageType_Close_Gray,           // 关闭
    NavImageType_Close_Circle,
    NavImageType_Setting_Gray,         // 设置
    NavImageType_Refresh_Gray,         // 刷新
} NavImageType;

@class ZCCustomTitleLabel;
@interface ZCBaseNavigationBar : UIView

/*
 返回按钮
 */
@property (nonatomic, strong) UIButton *backButton;

/*
 右侧按钮
 */
@property (nonatomic, strong) UIButton *rightButton;

/*
 文字标题
 */
@property (nonatomic, strong) ZCCustomTitleLabel *titleLabel;

/*
 图片标题
 */
@property (nonatomic, strong) UIImageView *titleImageView;

/*
 图片背景
 */
@property (nonatomic, strong) UIImageView *navBackImageView;

@property (nonatomic, strong) UIView   *barItem;
@property (nonatomic, strong) UIView   *bottomLine;

/*
 导航栏左侧按钮(多个)
 */
@property (nonatomic, strong) NSArray<UIButton *> *leftBarItems;

/*
 导航栏右侧按钮(多个)
 */
@property (nonatomic, strong) NSArray<UIButton *> *rightBarItems;

/*
 是否是大导航栏
 */
- (BOOL)isBigNavBar;

+ (ZCBaseNavigationBar *)navigationBar;

@end

@interface ZCCustomTitleLabel : UILabel

@end
