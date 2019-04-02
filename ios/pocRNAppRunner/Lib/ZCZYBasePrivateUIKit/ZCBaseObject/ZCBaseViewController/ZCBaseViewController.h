//
//  ZCBaseViewController.h
//  ZCZYBasePrivateUIKit
//
//  Created by kipling on 2018/10/22.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCBaseConfigure.h"
#import "ZCBaseNavigationBar.h"

@interface ZCBaseViewController : UIViewController

#pragma mark - property
/** 基类基础属性设置 */
@property (nonatomic, strong) ZCBaseConfigure *baseConfigure;

/**
 *  隐藏导航栏底部线条阴影开关
 */
@property (nonatomic, assign) BOOL hiddenNavigationBarShadowImageView;

// 由此改变自定义导航栏的默认属性
@property (nonatomic, strong, readonly) ZCBaseNavigationBar *navBar;

// 关闭系统侧滑pop default NO
@property (nonatomic,assign) BOOL closePopGestureRecognizer;

//default NO,是否隐藏系统导航(兼容跳转非自定义 navbar 控制器)
@property (nonatomic, assign) BOOL isNeedAutoHiddenSystemNav;

#pragma mark - function

/**
 *  出栈
 */
- (void)pop;

/**
 *  退回到Top
 */
- (void)popToRootVc;

/**
 退回到指定VC
 
 @param vc 指定控制器
 */
- (void)popToVc:(UIViewController *)vc;

/**
 *  Modal出的视图dismiss
 */
- (void)dismiss;

/**
 modal出某个视图控制器
 
 @param vc 指定视图控制器
 */
- (void)presentVc:(UIViewController *)vc;

/**
 modal出某个视图控制器, 带回调
 
 @param vc 指定视图控制器
 @param completion 回调
 */
- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion;

/**
 push到某指定视图控制器
 
 @param vc 指定视图控制器
 */
- (void)pushVc:(UIViewController *)vc;

/**
 移除子视图控制器
 
 @param childVc 指定视图控制器
 */
- (void)removeChildVc:(UIViewController *)childVc;

/*
 * 导航栏返回
 * 你不用关心你的View Controller是push or present的
 */
- (void)onBack:(id)sender;

// 导航栏右侧更多按钮响应函数
- (void)onNavRightItemClicked:(id)sender;

#pragma mark -- 配置函数

// 重写系统setTitle
- (void)setTitle:(NSString *)title;

// 设置animate flg when pop or dismiss
- (void)setNavBackAnimated:(BOOL)flag;

// 设置导航栏返回按钮隐藏
- (void)setNavBarBackItemHidden:(BOOL)bHidden;

// 设置导航栏右侧按钮隐藏(更多)
- (void)setNavBarRightItemHidden:(BOOL)bHidden;

// 设置导航栏隐藏
- (void)setNavBarHidden:(BOOL)bHidden;

// 设置状态栏
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle;

/*
 * 设置返回按钮图片
 * @para normalImage 正常状态image
 * @para hlImage     高亮状态image
 */
- (void)setNavBackImage:(UIImage *)normalImage
            highlighted:(UIImage *)hlImage;

@end
