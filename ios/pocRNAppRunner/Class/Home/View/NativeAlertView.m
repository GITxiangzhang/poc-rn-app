//
//  NativeAlertView.m
//  PocDemo
//
//  Created by Kipling on 2019/3/27.
//  Copyright © 2019年 Kipling. All rights reserved.
//

#import "NativeAlertView.h"
#import <KLCPopup/KLCPopup.h>
#import "BaseServerConfig.h"
#import <TZImagePickerController/UIView+Layout.h>

@interface NativeAlertView()

//弹出视图控件
@property (nonatomic, strong) KLCPopup *customPopup;
//输入框
@property (nonatomic, copy) CompleteEdit completeEdit;
@property (weak, nonatomic) IBOutlet UIButton *surebtn;

@end

@implementation NativeAlertView

- (void)dealloc {
  
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
  }
  return self;
}

- (void)showActionPopViewComplete:(CompleteEdit)complete {

  dispatch_async(dispatch_get_main_queue(), ^{
    [self.surebtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  });
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutCenter);
    KLCPopup *popup = [KLCPopup popupWithContentView:self
                                            showType:KLCPopupShowTypeShrinkIn
                                         dismissType:KLCPopupDismissTypeFadeOut
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    popup.dimmedMaskAlpha = 0.5;
    self.customPopup = popup;
    self.completeEdit = complete;
    [popup showWithLayout:layout];
}

- (IBAction)pop:(UIButton *)sender {
    if (self.completeEdit) {
        self.completeEdit(self.nativeTF.text);
    }
    [self.customPopup dismiss:YES];
}

#pragma mark -- keyboardWillShow && keyboardWillHide --
//监听的键盘升起响应
- (void)keyboardWillShow:(NSNotification *)notification {
  
  NSDictionary *userInfo = [notification userInfo];
  NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
  CGRect keyboardRect = [value CGRectValue];
  
  if (keyboardRect.size.height > (kScreenHeight - self.superview.tz_bottom)) {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.superview.tz_bottom = (kScreenHeight - keyboardRect.size.height - 5);
    [UIView commitAnimations];
  }
}

//键盘消失
- (void)keyboardWillHide {
  
  if(self.tz_centerY < kScreenHeight/2.f) {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.superview.center = CGPointMake(kScreenWidth/2.f, kScreenHeight/2.f);
    [UIView commitAnimations];
  }
}

@end
