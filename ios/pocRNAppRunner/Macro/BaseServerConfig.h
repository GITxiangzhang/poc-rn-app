//
//  BaseServerConfig.h
//  Pods
//
//  Created by liuhuan on 2017/7/6.
//
//

//#import <Toast/UIView+Toast.h>

#ifndef BaseServerConfig_h
#define BaseServerConfig_h

#define M6Scale (ScreenWidth/375.0) //横向等比例缩放
#define M6HeightScale (ScreenHeight/667) // 高度等比例缩放

//16进制颜色值
#define kHexColor(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]
#define kHexAlphaColor(hex,a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:a]
#define kRGB(a, b, c, opacity) [UIColor colorWithRed:(a / 255.0) green:(b / 255.0) blue:(c / 255.0) alpha:opacity]


#define mIsiP5 ([UIScreen mainScreen].bounds.size.height == 568.0)
#define mIsiP6 ([UIScreen mainScreen].bounds.size.height == 667.0)
#define mIsiP6P ([UIScreen mainScreen].bounds.size.height == 736.0)
#define isIphoneXX ([UIScreen mainScreen].bounds.size.height == 812.0||[UIScreen mainScreen].bounds.size.height == 896.0)

//app字体，使用以下方法获取字体，系统字体需要8.2版本以上，8.2以下用户暂不支持粗细，等9.0普及后在此将系统字体换成萍方字体
#define GetRegularFont(s) [[[UIDevice currentDevice] systemVersion] floatValue]>8.2?[UIFont fontWithName:@"PingFangSC-Regular" size:s]:[UIFont systemFontOfSize:s]

#define GetLightFont(s) [[[UIDevice currentDevice] systemVersion] floatValue]>8.2?[UIFont fontWithName:@"PingFangSC-Light" size:s]:[UIFont systemFontOfSize:s]

#define GetBoldFont(s) [[[UIDevice currentDevice] systemVersion] floatValue]>8.2?[UIFont fontWithName:@"PingFangSC-Semibold" size:s]:[UIFont systemFontOfSize:s]

#define GetMediumFont(s) [[[UIDevice currentDevice] systemVersion] floatValue]>8.2?[UIFont fontWithName:@"PingFangSC-Medium" size:s]:[UIFont systemFontOfSize:s]

#define kNavigationBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height + 44)
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define kTabbarHeight  ([UIScreen mainScreen].bounds.size.height == 812.0||896.0 ? 83:49)

// block self
#define mWeakSelf  __weak typeof (self)weakSelf = self;
#define mStrongSelf typeof(weakSelf) __strong strongSelf = weakSelf;

//trim string
#define TrimString(srcStr, trmStr) [srcStr stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:trmStr]]
#define TrimWhiteSpace(srcStr) [srcStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]

//判断ios系统版本
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

//屏幕尺寸
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenBounds [UIScreen mainScreen].bounds

// 字段过滤 只允许大小写文字母数字自汉字
#define kAlphaNum @"[\u4e00-\u9fa5_a-z_A-Z_0-9➋➌➍➎➏➐➑➒]*"

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

#ifdef DEBUG
//跟踪输出
#define NSLog(format, ...) do {                                             \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "----------------log--------------------\n");               \
} while (0)
#else
#define NSLog(...)
#endif

#endif /* BaseServerConfig_h */
