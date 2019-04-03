//
//  NativeAlertView.m
//  PocDemo
//
//  Created by Kipling on 2019/3/27.
//  Copyright © 2019年 Kipling. All rights reserved.
//

#import "NativeAlertView.h"
#import <KLCPopup/KLCPopup.h>

@interface NativeAlertView()

//弹出视图控件
@property (nonatomic, strong) KLCPopup *customPopup;
//输入框
@property (nonatomic, copy) CompleteEdit completeEdit;
@property (weak, nonatomic) IBOutlet UIButton *surebtn;

@end

@implementation NativeAlertView

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

@end
