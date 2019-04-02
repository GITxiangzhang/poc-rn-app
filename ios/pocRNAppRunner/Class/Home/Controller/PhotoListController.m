//
//  PhotoListController.m
//  Runner
//
//  Created by Kipling on 2019/3/30.
//  Copyright © 2019年 The Chromium Authors. All rights reserved.
//

#import "PhotoListController.h"
#import "BaseServerConfig.h"
#import "CameraCollectionCell.h"
#import "CameraDao.h"

@interface PhotoListController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *contentArr;

@end

@implementation PhotoListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"照片";
    [self initUI];
    [self initData];
}

- (void)initUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, kScreenWidth, kScreenHeight - kNavigationBarHeight) collectionViewLayout:layout];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"CameraCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    _collectionView.showsVerticalScrollIndicator = NO;
}

#pragma mark - UICollectionViewDelegate -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  _contentArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (kScreenWidth) / 4.f;
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CameraCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSData *data = _contentArr[indexPath.row];
    UIImage *image = [UIImage imageWithData:data];
    cell.photoImage.image = image;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

#pragma mark -- data --
- (void)initData {
    
    CameraDao *dao = [[CameraDao alloc] init];
    _contentArr = [NSMutableArray arrayWithArray:[dao getCameraImageData]];
    [self.collectionView reloadData];
}

@end
