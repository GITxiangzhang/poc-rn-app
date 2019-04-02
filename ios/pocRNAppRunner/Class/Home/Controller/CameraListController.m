//
//  CameraListController.m
//  Runner
//
//  Created by Kipling on 2019/3/30.
//  Copyright © 2019年 The Chromium Authors. All rights reserved.
//

#import "CameraListController.h"
#import "CameraViewController.h"
#import <Photos/Photos.h>
#import "TZImagePickerController.h"
#import "CameraDao.h"
#import "PhotoListController.h"

#define kCameraListDataArr @[@"相册",@"加密图片",@"拍照加密"]

@interface CameraListController()<UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation CameraListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Native List Page";
    self.tableView.showsVerticalScrollIndicator = NO;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate> --
- (NSInteger)ZC_numberOfSections {
    return 1;
}

- (NSInteger)ZC_numberOfRowsInSection:(NSInteger)section {
    return kCameraListDataArr.count;
}

- (CGFloat)ZC_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (ZCBaseTableViewCell *)ZC_cellAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCBaseTableViewCell *cell = [ZCBaseTableViewCell cellWithTableView:self.tableView];
    cell.textLabel.text = kCameraListDataArr[indexPath.row];
    return cell;
}

- (void)ZC_didSelectCellAtIndexPath:(NSIndexPath *)indexPath cell:(ZCBaseTableViewCell *)cell {
    
    switch (indexPath.row) {
        case 0:{
            //camera
            CameraViewController *vc = [[CameraViewController alloc] init];
            [self pushVc:vc];
        }
            break;
        case 1:{
            //预览
            PhotoListController *vc = [[PhotoListController alloc] init];
            [self pushVc:vc];
        }
            break;
        case 2:{
            //camera
            [self showAlertView];
        }
            break;
            
        default:
            break;
    }
}

- (void)showAlertView {
    
    NSString *takePhotoTitle = @"相机";
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhotoTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    [alertVc addAction:takePhotoAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVc addAction:cancelAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)takePhoto {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

- (void)pushImagePickerController {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
    }];
}

#pragma mark - UIImagePickerControllerDelegate,UINavigationControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    //压缩图片
    CGSize newSize = CGSizeMake(500, 500);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self saveImageToDataBaseWithImage:newImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImageToDataBaseWithImage:(UIImage *)originImage {
    
//    NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
//    NSString *encodedImageStr =[[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];;
//    NSLog(@"Encoded image:%@", encodedImageStr);
    
    CameraDao *dao = [[CameraDao alloc] init];
    [dao insertDatabaseWithImage:originImage];
}

@end
