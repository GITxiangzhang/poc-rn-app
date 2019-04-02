/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "BaiduMapViewManager.h"

#import "PocRootViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#define kAMapKit_APPKEY @"f55415062e4f10257c0c74b5b259027a"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

//  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
//  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
//                                                   moduleName:@"pocRNApp"
//                                            initialProperties:nil];
//  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
//  [BaiduMapViewManager initSDK:@"OGLCu52Y34t36RdzEzsm8yzwbRL0F09H"];
//
//  UIViewController *rootViewController = [UIViewController new];
//  rootViewController.view = rootView;
//  self.window.rootViewController = rootViewController;
  
  /**  高德地图 */
  [self initAMapKit];
  self.window.rootViewController = [self initialRootViewController];
  
  [self.window makeKeyAndVisible];
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

- (UIViewController *)initialRootViewController {
  
  PocRootViewController *tabBarVC = [[PocRootViewController alloc] init];
  return tabBarVC;
}

/** 初始化高德地图 APi */
-(void)initAMapKit{
  if ([kAMapKit_APPKEY length] == 0){
    return;
  }
  [AMapServices sharedServices].apiKey = kAMapKit_APPKEY;
}

@end
