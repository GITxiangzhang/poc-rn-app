//
//  PocRootViewController.m
//  PocDemo
//
//  Created by Kipling on 2019/3/22.
//  Copyright © 2019年 Kipling. All rights reserved.
//

#import "PocRootViewController.h"
#import "BaseServerConfig.h"
#import "ListViewController.h"
#import "WebViewController.h"
#import "SettingViewController.h"
#import "ZCBaseNavgationController.h"

@interface PocRootViewController ()

@end

@implementation PocRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor colorWithRed:0.29 green:0.55 blue:0.94 alpha:1.00];
    
    ListViewController *homeVC = [[ListViewController alloc] init];
    ZCBaseNavgationController *homeNav = [[ZCBaseNavgationController alloc] initWithRootViewController:homeVC];
    homeNav.tabBarItem.title = @"List";
    [homeNav.tabBarItem setImage:[self imageOriginal:@"icon_list_normal"]];
    [homeNav.tabBarItem setSelectedImage:[self imageOriginal:@"icon_list_select"]];
    
    WebViewController *inquireVC = [[WebViewController alloc] init];
    ZCBaseNavgationController *inquireNav = [[ZCBaseNavgationController alloc] initWithRootViewController:inquireVC];
    inquireNav.tabBarItem.title = @"Web";
    [inquireNav.tabBarItem setImage:[self imageOriginal:@"icon_web_normal"]];
    [inquireNav.tabBarItem setSelectedImage:[self imageOriginal:@"icon_web_select"]];
    
    SettingViewController *individualVC = [[SettingViewController alloc] init];
    ZCBaseNavgationController *individuaNav = [[ZCBaseNavgationController alloc] initWithRootViewController:individualVC];
    individuaNav.tabBarItem.title = @"Setting";
    [individuaNav.tabBarItem setImage:[self imageOriginal:@"icon_setting_normal"]];
    [individuaNav.tabBarItem setSelectedImage:[self imageOriginal:@"icon_setting_select"]];
    
    self.viewControllers = @[homeNav, inquireNav, individuaNav];
}

- (UIImage *)imageOriginal:(NSString *)name {
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

#pragma mark - autorotate
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
