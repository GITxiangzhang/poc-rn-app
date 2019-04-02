//
//  ZCBaseNavgationController.m
//  IndividualCenter
//
//  Created by kipling on 2018/10/29.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import "ZCBaseNavgationController.h"

@interface ZCBaseNavgationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

// navigation controller 最顶部的controller
@property (nonatomic,weak) UIViewController *activeVController;

@end

@implementation ZCBaseNavgationController

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
    return self;
}

// { fixed 侧滑引起的bug
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    if (navigationController.viewControllers.count == 1) {
        self.activeVController = nil;
    }else {
        self.activeVController = viewController;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.activeVController == self.topViewController)?YES:NO;
    }
    return YES;
}
// }

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL) shouldAutorotate {
    return NO;
}

@end
