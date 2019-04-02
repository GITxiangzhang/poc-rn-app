//
//  ZYNavbarContext.m
//  ZCZYBasePrivateUIKit
//
//  Created by kipling on 2018/11/12.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import "ZYNavbarContext.h"

@interface ZYNavbarContext () {
    
    NSUInteger _lastSeletedTabIndex; // Default 0
}

@end

@implementation ZYNavbarContext

+ (ZYNavbarContext *)sharedContext {
    static ZYNavbarContext *context = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        context = [[ZYNavbarContext alloc] init];
    });
    return context;
}

- (UITabBarController *)rootViewController {
    // [UIApplication sharedApplication].keyWindow
    UITabBarController *rootvc = (UITabBarController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
    if (nil != rootvc && [rootvc isKindOfClass:[UITabBarController class]]) {
        return rootvc;
    }
    return nil;
}

/*
 * 切换到 index tab
 */
- (void)switchToTapIndex:(NSUInteger)index {
    NSInteger count = ([self rootViewController].viewControllers.count);
    if (index < count) {
        // 纪录上次选中的tab index
        _lastSeletedTabIndex = [self rootViewController].selectedIndex;
        [[self rootViewController] setSelectedIndex:index];
    }
}

/*
 * 获取 index
 */
- (UINavigationController *)navigationWithIndex:(NSUInteger)index {
    NSInteger count = ([self rootViewController].viewControllers.count);
    if (index < count) {
        return ([[[self rootViewController] viewControllers] objectAtIndex:index]);
    }
    return nil;
}

/*
 * 当前选中 index
 */
- (UINavigationController *)selected {
    return [self rootViewController].selectedViewController;
}

/*
 * 当前选中tab下的 topViewController
 */
- (UINavigationController *)topNavigation {
    
    UINavigationController *nav = [self selected];
    // this is not 'return nav.topViewController.navigationController'
    return nav.visibleViewController.navigationController;
}

/*
 * Unbalanced calls to begin/end appearance transitions
 * 注意，这里会有个警告、在某些系统上 甚至crash 当dismissViewController时候
 * 解决方法:延时
 */
- (BOOL)isNeedDelayWhenClearViewCtrlers {
    UITabBarController *vc = [self rootViewController];
    return (nil != vc.presentedViewController) ? YES : NO;
}

/*
 * 清除root tabBarController下 所有view controllers
 */
- (void)clearViewCtrlers {
    UITabBarController *vc = [self rootViewController];
    if (vc.presentedViewController) {
        [vc dismissViewControllerAnimated:NO completion:nil];
    }
    
    NSArray *vcs = [self rootViewController].viewControllers;
    if (nil != vcs && vcs.count > 0) {
        for (UINavigationController *vc in vcs) {
            if (nil != vc && [vc isKindOfClass:[UINavigationController class]]) {
                [vc popToRootViewControllerAnimated:NO];
            }
        }
    }
}

/*
 * 清除root tabBarController下 所有view controllers
 * @paras 'complete' : clear完成后会调用complete
 */
- (void)clearViewCtrlersWithCommplete:(dispatch_block_t)complete {
    
    BOOL isNeedDelay = [self isNeedDelayWhenClearViewCtrlers];
    [self clearViewCtrlers];
    
    if (isNeedDelay) {
        // Unbalanced calls to begin/end appearance transitions
        // 注意，这里会有个警告、在某些系统上 甚至crash 当dismissViewController时候
        // call 'complete()' after the seconds
        double delayInSeconds = .5f;// not modify value (05f)!!!
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds*NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            complete();
        });
    }else {
        if (!([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending)) {
            double delayInSeconds = .5f;// not modify value (05f)!!!
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds*NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                complete();
            });
        }
        else {
            complete();
        }
    }
}

/*
 * 清除root tabBarController下 所有presentedViewController
 * @paras 'complete' : clear完成后会调用complete
 */

- (void)clearPresentedViewControllerWithCommplete:(dispatch_block_t)complete {
    BOOL isNeedDelay = [self isNeedDelayWhenClearViewCtrlers];
    
    if (isNeedDelay) {
        UIViewController *vc = [self rootViewController];
        if (vc.presentedViewController) {
            [vc dismissViewControllerAnimated:NO completion:nil];
        }
        
        // Unbalanced calls to begin/end appearance transitions
        // 注意，这里会有个警告、在某些系统上 甚至crash 当dismissViewController时候
        // call 'complete()' after the seconds
        double delayInSeconds = .5f;// not modify value (05f)!!!
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds*NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (complete) {
                complete();
            }
        });
        
    }else {
        if (complete) {
            complete();
        }
    }
}

/*
 * 清除root tabBarController下 所有view controllers
 * @paras 'controller' : clear完成后,push controller
 */

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (nil != viewController && [viewController isKindOfClass:[UIViewController class]]) {
        [self clearViewCtrlersWithCommplete:^{
            [[[ZYNavbarContext sharedContext] topNavigation] pushViewController:viewController animated:animated];
        }];
    }
}

/*
 * 清除root tabBarController下 所有view controllers
 * @paras 'controller' : clear完成后,present controller
 */
- (void)presentViewController:(UINavigationController *)viewController animated: (BOOL)flag completion:(void (^)(void))completion {
    if (nil != viewController && [viewController isKindOfClass:[UINavigationController class]]) {
        [self clearViewCtrlersWithCommplete:^{
            [[[ZYNavbarContext sharedContext] topNavigation] presentViewController:viewController animated:YES completion:completion];
        }];
    }
}

/*
 * 清除root tabBarController下 所有view controllers
 * @paras tabIndex : clear完成后:切换到index tab
 * @paras controller :
 *        如果controller是UINavigationController, present controller \
 *        如果controller是UIViewController, push controller \
 */

- (void)switchToTabIndex:(NSUInteger)tabIndex targetCtrler:(UIViewController *)controller animated:(BOOL)animated {
    if (nil != controller && [controller isKindOfClass:[UIViewController class]]) {
        [self clearViewCtrlersWithCommplete:^{
            [[ZYNavbarContext sharedContext] switchToTapIndex:tabIndex];
            [[[ZYNavbarContext sharedContext] topNavigation] pushViewController:controller animated:animated];
        }];
    }else if (nil != controller && [controller isKindOfClass:[UINavigationController class]]) {
        [self clearViewCtrlersWithCommplete:^{
            [[ZYNavbarContext sharedContext] switchToTapIndex:tabIndex];
            [[[ZYNavbarContext sharedContext] topNavigation] presentViewController:controller animated:animated completion:nil];
        }];
    }
}

/*
 * 纪录上个选中的tab index
 */
- (NSUInteger)lastSeletedTabIndex {
    return _lastSeletedTabIndex;
}

/*
 * 清除所有后，回到首页 (可能存在延时)
 */
- (void)goToHome {
    
    __weak typeof(self) weakSelf = self;
    [self clearViewCtrlersWithCommplete:^{
        [weakSelf switchToTapIndex:0];
    }];
}

@end
