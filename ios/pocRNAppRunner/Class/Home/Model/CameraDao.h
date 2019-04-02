//
//  CameraDao.h
//  Runner
//
//  Created by Kipling on 2019/3/30.
//  Copyright © 2019年 The Chromium Authors. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SNDAO.h"

NS_ASSUME_NONNULL_BEGIN

@interface CameraDao : SNDAO

- (void)insertDatabaseWithImage:(UIImage *)image;
- (NSArray *)getCameraImageData;

@end

NS_ASSUME_NONNULL_END
