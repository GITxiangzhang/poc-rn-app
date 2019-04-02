//
//  ReactNativeContainerVC.m
//  Runner
//
//  Created by Kipling on 2019/3/27.
//  Copyright © 2019年 The Chromium Authors. All rights reserved.
//

#import "ReactNativeContainerVC.h"
#import "BaseServerConfig.h"
#import "NativeAlertView.h"
#import <React/RCTRootView.h>
#import <React/RCTBundleURLProvider.h>

@interface ReactNativeContainerVC ()

//弹出框
@property (nonatomic, strong) NativeAlertView *alertView;

@end

@implementation ReactNativeContainerVC

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(showWithCallback:(RCTResponseSenderBlock)callback){
  //do something you want
  dispatch_async(dispatch_get_main_queue(), ^{
    self.alertView.nativeTF.text = @"";
  });
  [self.alertView showActionPopViewComplete:^(NSString *text) {
    if (text) {
      callback(@[text,@"call back from native"]);
    }else {
      callback(@[[NSNull null],@"call back from native"]);
    }
  }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any add2itional setup after loading the view.
    self.title = @"react native view";
  
  NSURL *jsCodeLocation = [self sourceURL];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"pocRNApp"
                                               initialProperties:nil
                                                   launchOptions:nil];
  rootView.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight);
  [self.view addSubview:rootView];
}

- (NativeAlertView *)alertView {
    if (!_alertView) {
        _alertView = [[NSBundle mainBundle] loadNibNamed:@"NativeAlertView" owner:nil options:nil].firstObject;
        _alertView.frame = CGRectMake(0, 0, 300, 180);
    }
    return _alertView;
}

- (NSURL *)sourceURL {
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
