//
//  ZCBaseNavgationController.h
//  IndividualCenter
//
//  Created by kipling on 2018/10/29.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * (1)统一NavigationController入口
 * (2)解决 自定义导航栏返回 引起系统侧滑失效
 *
 * 注意：fixe the follow bugs
 * 当正在push animated 未完成的时候，侧滑返回 会引起crash
 * 当正在pop animated 未完成的时候，侧滑返回 会引起卡死
 */

@interface ZCBaseNavgationController : UINavigationController

/*
 * Convenience method pushes the root view controller without animation.
 */
- (id)initWithRootViewController:(UIViewController *)rootViewController;

@end
