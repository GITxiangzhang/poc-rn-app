//
//  ZCBaseNavigationBar.m
//  IndividualCenter
//
//  Created by kipling on 2018/10/29.
//  Copyright © 2018年 kipling. All rights reserved.
//

#import "ZCBaseNavigationBar.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//16进制色值参数转换
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ZCBaseNavigationBar ()

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) BOOL isBigNavBar;

@end

@implementation ZCBaseNavigationBar

+ (ZCBaseNavigationBar *)navigationBar {
    ZCBaseNavigationBar *bar = [[ZCBaseNavigationBar alloc] init];
    bar.frame = CGRectMake(.0f,.0f, kScreenWidth, 64.0f);
    return bar;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _isAnimating = NO;
        _isBigNavBar = NO;
        self.backgroundColor = [UIColor whiteColor];
        
        [self.barItem addSubview:self.titleLabel];
        [self.barItem addSubview:self.titleImageView];
        
        [self.barItem addSubview:self.backButton];
        [self.barItem addSubview:self.rightButton];
        
        [self addSubview:self.navBackImageView];
        [self addSubview:self.barItem];
        [self addSubview:self.bottomLine];
        
        _leftBarItems = [[NSArray alloc] init];
        _rightBarItems = [[NSArray alloc] init];
    }
    return self;
}

/*
 根据导航栏各功能获取对应图片
 */
- (NSString *)getNavImageNameWithType:(NavImageType)imageType {
    NSString *imgName = @"";
    switch (imageType) {
        case NavImageType_Back_Gray:
            imgName = @"zcbase_nav_back_gray";
            break;
        default:
            break;
    }
    
    return imgName;
}

/*
 返回按钮
 */
- (UIButton *)backButton {
    if (nil == _backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(6.0f, 7.0f, 30.f, 30.f)];
        [_backButton setImage:[UIImage imageNamed:[self getNavImageNameWithType:NavImageType_Back_Gray]]
                     forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:[self getNavImageNameWithType:NavImageType_Back_Gray]]
                     forState:UIControlStateHighlighted];
        _backButton.accessibilityLabel = @"返回";
    }
    return _backButton;
}

/*
 右侧按钮
 */
- (UIButton *)rightButton {
    if (nil == _rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 100 - 15, self.barItem.frame.size.height - 44.f, 100.f, 44.f)];
       _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _rightButton;
}

/*
 标题
 */
- (ZCCustomTitleLabel *)titleLabel {
    if (nil == _titleLabel)
    {
        _titleLabel = [[ZCCustomTitleLabel alloc] init];
        _titleLabel.frame = CGRectMake(0, 0, 150.f, 44.0f);
        _titleLabel.center = CGPointMake(self.barItem.frame.size.width/2, 22);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font      = [UIFont boldSystemFontOfSize:18.0f];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.accessibilityLabel = @"标题";
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

/*
 标题图片
 */
- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc] init];
        _titleImageView.frame = CGRectMake(0, 0, 84, 20);
        _titleImageView.center = CGPointMake(self.barItem.frame.size.width/2, 22);
        _titleImageView.hidden = YES;
    }
    return _titleImageView;
}

/*
 背景图片
 */
- (UIImageView *)navBackImageView {
    if (!_navBackImageView) {
        _navBackImageView = [[UIImageView alloc] init];
        _navBackImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _navBackImageView.hidden = YES;
    }
    return _navBackImageView;
}

- (UIView *)barItem {
    if (nil == _barItem) {
        _barItem = [[UIView alloc] initWithFrame:CGRectMake(.0f, 20.0f, kScreenWidth, 44.0f)];
        _barItem.backgroundColor = [UIColor clearColor];
    }
    return _barItem;
}

- (UIView *)bottomLine {
    if (nil == _bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(.0f,63.5f,kScreenWidth,0.5)];
        _bottomLine.backgroundColor = RGBACOLOR(230.f, 230.f, 230.f, 1.f);
    }
    return _bottomLine;
}

- (BOOL)isBigNavBar {
    return _isBigNavBar;
}

/*
 设置左侧多个按钮
 */
- (void)setLeftBarItems:(NSArray<UIButton *> *)leftBarItems {
    if (nil != leftBarItems) {
        if (_leftBarItems.count > 0) {
            for (UIButton *barItem in _leftBarItems)
            {
                [barItem removeFromSuperview];
            }
        }
        _leftBarItems = leftBarItems;
        self.backButton.hidden = YES;
        NSInteger index = 0;
        for (UIButton *button in leftBarItems) {
            if (index > 1) {
                break;
            }
            button.frame = CGRectMake(6 + (30 + 15) * index, 7, 30, 30);
            [self.barItem addSubview:button];
            index += 1;
        }
    }
}

/*
 设置右侧多个按钮
 */
- (void)setRightBarItems:(NSArray<UIButton *> *)rightBarItems {
    if (nil != rightBarItems) {
        if (_rightBarItems.count > 0) {
            for (UIButton *barItem in _rightBarItems)
            {
                [barItem removeFromSuperview];
            }
        }
        _rightBarItems = rightBarItems;
        self.rightButton.hidden = YES;
        NSInteger index = 0;
        for (UIButton *button in rightBarItems) {
            if (index > 2) {
                break;
            }
            button.frame = CGRectMake((kScreenWidth - 12 - 30 - (30 + 15) * index), 7, 30, 30);
            [self.barItem addSubview:button];
            index += 1;
        }
    }
}

@end

@implementation ZCCustomTitleLabel

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setText:(NSString *)text {
//    NSAssert(text.length <= 10, @"标题不能超过10个字");
    if (text && ![text isEqualToString:@""])
    {
        self.frame = CGRectMake(0, 0, 250.f, 44.0f);
        NSString  *subTitle = text;
        [super setText:subTitle];
        [self sizeToFit];
        self.center = CGPointMake(self.superview.frame.size.width/2, 22);
    } else {
        [super setText:@""];
        self.frame = CGRectMake(0, 0, 1.f, 22.0f);
        self.center = CGPointMake(self.superview.frame.size.width/2, 22);
    }
}

@end

