//
//  ZCBaseConfigure.h
//  ZCZYBasePrivateUIKit
//
//  Created by kipling on 2018/10/22.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZCBaseConfigure : NSObject

/** 视图控制器背景色 */
@property (nonatomic, strong) UIColor *viewBackgroundColor;
/** navigationBar barTintColor */
@property (nonatomic, strong) UIColor *navigationBar_barTintColor;
/** navigationBar tintColor */
@property (nonatomic, strong) UIColor *navigationBar_tintColor;
/** navigationBar backTitle */
@property (nonatomic, copy) NSString *navigationBar_backTitle;
/** 导航栏样式 */
@property (nonatomic, assign) UIBarStyle navigationBar_barStyle;
/** 导航标题样式 */
@property (nonatomic, strong) NSDictionary *navigationBar_titleAttributes;
/** 是否隐藏导航底部虚线 */
@property (nonatomic, assign) BOOL hiddeNavShadowImageView;
/** 项目主色调 */
@property (nonatomic, strong) UIColor *baseColor;
/** 状态栏样式 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@end
