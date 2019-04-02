//
//  ZYNavbarContext.h
//  ZCZYBasePrivateUIKit
//
//  Created by kipling on 2018/11/12.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYNavbarContext : NSObject

/*
 * 统一管理TabBarController
 * 你可以更容易获取根UINavigationController
 */
+ (ZYNavbarContext *)sharedContext;

- (UITabBarController *)rootViewController;

/*
 * 切换到 index tab
 */
- (void)switchToTapIndex:(NSUInteger)index;

/*
 * 获取 index
 */
- (UINavigationController *)navigationWithIndex:(NSUInteger)index;

/*
 * 当前选中 index
 */
- (UINavigationController *)selected;

/*
 * 当前选中tab下的 topViewController
 */
- (UINavigationController *)topNavigation;

@end

NS_ASSUME_NONNULL_END
