//
//  NativeAlertView.h
//  PocDemo
//
//  Created by Kipling on 2019/3/27.
//  Copyright © 2019年 Kipling. All rights reserved.
//  原生弹出框

#import <UIKit/UIKit.h>

typedef void(^CompleteEdit)(NSString *text);
@interface NativeAlertView : UIView

@property (weak, nonatomic) IBOutlet UITextField *nativeTF;

//显示视图
- (void)showActionPopViewComplete:(CompleteEdit)complete;

@end

