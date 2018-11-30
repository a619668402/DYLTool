//
//  TestHXPhotoPicker.m
//  DYLTool
//
//  Created by sky on 2018/7/27.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "TestHXPhotoPicker.h"
#import <HXPhotoPicker/HXPhotoConfiguration.h>
#import <HXPhotoPicker/HXPhotoPicker.h>

#import "YLNiNeView.h"

@interface TestHXPhotoPicker ()<HXAlbumListViewControllerDelegate, YLNineViewDelegate, HXPhotoViewDelegate>

@property (nonatomic, strong) YLNiNeView *nineView;

@property (nonatomic, strong) HXPhotoView *photoView;

@property (nonatomic, strong) HXPhotoManager *photoManager;

@end

@implementation TestHXPhotoPicker

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)yl_initValues {
    [super yl_initValues];
}

- (void)yl_initViews {
    [super yl_initViews];
    [self _createBtn];
    [self.view addSubview:self.nineView];
//    [self.view addSubview:self.photoView];
}

- (void)_createBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"Click" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(_click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, KNavAndStatusHeight + 20, 70, 30);
}

- (void)_click:(UIButton *)btn {
//    HXPhotoManager *manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
//    manager.configuration.openCamera = YES;
//    manager.configuration.saveSystemAblum = YES;
//
//    [self hx_presentAlbumListViewControllerWithManager:manager delegate:self];
    [self.photoView goPhotoViewController];
}

/**
 点击取消
 
 @param albumListViewController self
 */
- (void)albumListViewControllerDidCancel:(HXAlbumListViewController *)albumListViewController {
    KLogFunc;
}

/**
 点击完成时获取图片image完成后的回调
 选中了原图返回的就是原图
 需 requestImageAfterFinishingSelection = YES 才会有回调
 
 @param albumListViewController self
 @param imageList 图片数组
 */
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllImage:(NSArray<UIImage *> *)imageList {
    KLogFunc;
}

/**
 点击完成
 
 @param albumListViewController self
 @param allList 已选的所有列表(包含照片、视频)
 @param photoList 已选的照片列表
 @param videoList 已选的视频列表
 @param original 是否原图
 */
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original {
    KLogFunc;
    NSMutableArray *array = [NSMutableArray array];
    for (HXPhotoModel *model in photoList) {
        [array addObject:model.fileURL];
    }
    self.nineView.dataSource = array;
    float height = ((KScreenWidth - 5) / 4.f + 1) * (array.count / 4 + 1);
    self.nineView.frame = CGRectMake(0, KNavAndStatusHeight + 60, KScreenWidth, height);
}

- (YLNiNeView *)nineView {
    if (!_nineView) {
        _nineView = [[YLNiNeView alloc] init];
        _nineView.delegate = self;
        _nineView.frame = CGRectMake(0, KNavAndStatusHeight + 60, KScreenWidth, (KScreenWidth - 5) / 4.f);
        _nineView.backgroundColor = [UIColor greenColor];
    }
    return _nineView;
}

- (HXPhotoView *)photoView {
    if (!_photoView) {
        _photoView = [HXPhotoView photoManager:self.photoManager];
        _photoView.frame = CGRectMake(0, KNavAndStatusHeight + 60, KScreenWidth, 0);
        _photoView.delegate = self;
        _photoView.previewShowDeleteButton = YES;
        _photoView.showAddCell = YES;
        _photoView.lineCount = 4;
        [_photoView.collectionView reloadData];
        _photoView.backgroundColor = white_color;
    }
    return _photoView;
}

- (HXPhotoManager *)photoManager {
    if (!_photoManager) {
        _photoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _photoManager.configuration.openCamera = YES;
        _photoManager.configuration.saveSystemAblum = YES;
        _photoManager.configuration.rowCount = 5;
        _photoManager.configuration.photoMaxNum = 9;
        _photoManager.configuration.videoMaxNum = 0;
        _photoManager.configuration.showDateSectionHeader = NO;
    }
    return _photoManager;
}

- (void)yl_addCellClick {
    HXPhotoManager *manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
    manager.configuration.openCamera = YES;
    manager.configuration.saveSystemAblum = YES;
    manager.configuration.rowCount = 4;
    manager.configuration.photoMaxNum = 2;
    manager.configuration.videoMaxNum = 0;
    manager.configuration.showDateSectionHeader = NO;
//    [self hx_presentAlbumListViewControllerWithManager:manager delegate:self];
}

@end
