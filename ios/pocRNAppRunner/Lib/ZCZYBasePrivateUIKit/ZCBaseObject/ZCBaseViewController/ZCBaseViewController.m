//
//  ZCBaseViewController.m
//  ZCZYBasePrivateUIKit
//
//  Created by kipling on 2018/10/22.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import "ZCBaseViewController.h"
#import <objc/runtime.h>

const char ZCBaseVcNavRightItemHandleKey;
const char ZCBaseVcNavLeftItemHandleKey;
#define kBaseViewBackgroundColor [UIColor colorWithRed:239/255.f green:240/255.f blue:243/255.f alpha:1.000]

@interface ZCBaseViewController () {
    UIImageView *_navShadowImageView;
    BOOL _isAnimatedWhenPopOrDismiss; // animated flag when pop or dismiss,default YES
    BOOL _isNavBarHidden; // default NO,是否隐藏导航栏
    BOOL _isNavBackItemHidden; // default NO,是否隐藏导航栏 返回按钮
    BOOL _isNavRightItemHidden; // default YES,是否隐藏导航栏 右侧更多按钮
    UIStatusBarStyle _statusBarStyle;
}

@property (nonatomic, strong) ZCBaseNavigationBar *kNavBar;
@property (nonatomic, copy) NSString *titleString;
/**
 *  自动隐藏导航栏, 实现过度效果
 */
@property (nonatomic, assign) BOOL autoHiddenNavigationBar;

@end

@implementation ZCBaseViewController

- (void)dealloc {
    /*
     * 如果你的ViewController当pop或dismiss后 未走或未及时走dealloc函数，请引起重视!!!
     */
#if DEBUG
    NSLog(@"dealloc: %@",self);
#endif
}

#ifdef __IPHONE_11_0
- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    
    CGRect oldframe0 = self.navBar.frame;
    oldframe0.size.height = self.view.safeAreaInsets.top + (self.navBar.isBigNavBar?86:44);
    self.navBar.frame = oldframe0;
    
    CGRect oldframe1 = self.navBar.barItem.frame;
    oldframe1.origin.y = self.view.safeAreaInsets.top;
    self.navBar.barItem.frame = oldframe1;
    
    CGRect oldframe2 = self.navBar.bottomLine.frame;
    oldframe2.origin.y = self.navBar.frame.size.height + self.navBar.frame.origin.y - 0.5f;
    self.navBar.bottomLine.frame = oldframe2;
}
#endif

- (id)init {
    if (self = [super init]) {
//        self.hidesBottomBarWhenPushed = YES;
        _isAnimatedWhenPopOrDismiss   = YES;
        _isNavBarHidden               = NO;
        _isNavBackItemHidden          = NO;
        _isNeedAutoHiddenSystemNav    = NO;
        _isNavRightItemHidden         = YES;
        _statusBarStyle               = UIStatusBarStyleLightContent;
        // 强制隐藏系统导航栏
        self.navigationController.navigationBarHidden = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (ZCBaseNavigationBar *)kNavBar {
    if (nil == _kNavBar) {
        _kNavBar = [ZCBaseNavigationBar navigationBar];
        _kNavBar.backgroundColor = [UIColor colorWithRed:0.29 green:0.55 blue:0.94 alpha:1.00];

        [_kNavBar.backButton addTarget:self
                                action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
        [_kNavBar.rightButton addTarget:self
                                 action:@selector(onNavRightItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kNavBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBaseViewBackgroundColor;
    
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.kNavBar];
    
    [self setNavBarHidden:_isNavBarHidden];
    [self setNavBarBackItemHidden:_isNavBackItemHidden];
    [self setNavBarRightItemHidden:_isNavRightItemHidden];
    self.kNavBar.titleLabel.text = _titleString;
    
    _navShadowImageView = [self findShadowImageViewUnder:self.navigationController.navigationBar];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //修复跳转到自定义导航栏时重复导航的问题
    self.navigationController.navigationBarHidden = YES;

    _navShadowImageView.hidden = NO;
    if (self.hiddenNavigationBarShadowImageView) {
        _navShadowImageView.hidden = YES;
    }
    
    // 状态栏
    [self setStatusBarStyle:_statusBarStyle];
    
    // 自定导航栏
    if (!_isNavBarHidden && nil != _kNavBar) {
        [_kNavBar.superview bringSubviewToFront:_kNavBar];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 系统侧滑使能
    self.navigationController.interactivePopGestureRecognizer.enabled = !_closePopGestureRecognizer;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = _isNeedAutoHiddenSystemNav;
}

- (void)setBaseConfigure:(ZCBaseConfigure *)baseConfigure {
    if (!baseConfigure) {
        baseConfigure = [[ZCBaseConfigure alloc] init];
    }
    
    _baseConfigure = baseConfigure;
    self.navigationController.navigationBar.barTintColor = baseConfigure.navigationBar_barTintColor;
    self.navigationController.navigationBar.tintColor = baseConfigure.navigationBar_tintColor;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:baseConfigure.navigationBar_backTitle style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationController.navigationBar.barStyle = baseConfigure.navigationBar_barStyle;
    [self.navigationController.navigationBar setTitleTextAttributes:baseConfigure.navigationBar_titleAttributes];
    
    self.view.backgroundColor = baseConfigure.viewBackgroundColor;
    self.hiddenNavigationBarShadowImageView = baseConfigure.hiddeNavShadowImageView;
    
    [[UINavigationBar appearance] setBarTintColor: baseConfigure.navigationBar_barTintColor];
    [UIApplication sharedApplication].statusBarStyle = baseConfigure.statusBarStyle;
}

- (void)popGotBack {
    if (self.navigationController == nil) return ;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pop {
    if (self.navigationController == nil) return ;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRootVc {
    if (self.navigationController == nil) return ;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    _isNeedAutoHiddenSystemNav = YES;
    [self presentVc:vc completion:nil];
}

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:completion];
}

- (void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
}

- (void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = self.view.bounds;
}

- (void)addChildViewController:(UIViewController *)childController {
    [super addChildViewController:childController];
    
    if (nil != childController
        && [childController isKindOfClass:[ZCBaseViewController class]]) {
        ZCBaseViewController *vc = (ZCBaseViewController *)childController;
        [vc setNavBarHidden:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait ;
}

- (BOOL)shouldAutorotate {
    return NO;
}

#pragma mark -- private method --
/** 导航栏底部的隐形*/
- (UIImageView *)findShadowImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subView in view.subviews) {
        UIImageView *imageView = [self findShadowImageViewUnder:subView];
        if (imageView) {
            return  imageView;
        }
    }
    return nil;
}

- (BOOL)isTranslucent {
    return NO;
}

- (void)setHiddenNavigationBarShadowImageView:(BOOL)hiddenNavigationBarShadowImageView {
    _hiddenNavigationBarShadowImageView = hiddenNavigationBarShadowImageView;
    
    if (hiddenNavigationBarShadowImageView) {
        _navShadowImageView.hidden = YES;
    }
}

- (UIView *)navBarItemView {
    return self.kNavBar.barItem;
}

- (NSString *)title {
    return _titleString;
}

- (void)setTitle:(NSString *)title {
    
    _titleString = title;
    _kNavBar.titleLabel.text = _titleString;
}

- (ZCBaseNavigationBar *)navBar {
    return self.kNavBar;
}

#pragma mark -- 点击事件 --
- (void)onBack:(id)sender {
    NSArray *vcs = self.navigationController.viewControllers;
    if (vcs.count > 1 && [vcs objectAtIndex:vcs.count-1] == self) {
        // View is disappearing because a new view controller was pushed onto the stack
        [self.navigationController popViewControllerAnimated:_isAnimatedWhenPopOrDismiss];
    }else {
        [self dismissViewControllerAnimated:_isAnimatedWhenPopOrDismiss completion:nil];
    }
}

// 导航栏右侧更多按钮
- (void)onNavRightItemClicked:(id)sender {
}

#pragma mark -- private --
// 设置导航栏隐藏
- (void)setNavBarHidden:(BOOL)bHidden {
    _isNavBarHidden = bHidden;
    
    // 自定义导航栏
    _kNavBar.hidden = _isNavBarHidden;
}

// 设置导航栏返回按钮隐藏
- (void)setNavBarBackItemHidden:(BOOL)bHidden {
    _isNavBackItemHidden = bHidden;
    _kNavBar.backButton.hidden = _isNavBackItemHidden;
}

// 设置导航栏右侧按钮隐藏(更多)
- (void)setNavBarRightItemHidden:(BOOL)bHidden {
    _isNavRightItemHidden = bHidden;
    _kNavBar.rightButton.hidden = _isNavRightItemHidden;
}

// 设置animate flg when pop or dismiss
- (void)setNavBackAnimated:(BOOL)flag {
    _isAnimatedWhenPopOrDismiss = flag;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    
    if (_statusBarStyle != [UIApplication sharedApplication].statusBarStyle) {
        [UIApplication sharedApplication].statusBarStyle = _statusBarStyle;
    }
}

// 获取状态栏样式
- (UIStatusBarStyle)statusBarStyle {
    return _statusBarStyle;
}

/*
 * 设置返回按钮图片
 * @para normalImage 正常状态image
 * @para hlImage     高亮状态image
 */
- (void)setNavBackImage:(UIImage *)normalImage
            highlighted:(UIImage *)hlImage {
    [_kNavBar.backButton setImage:normalImage
                         forState:UIControlStateNormal];
    [_kNavBar.backButton setImage:hlImage
                         forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
