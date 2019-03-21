//
//  WYASendDynamicViewController.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/15.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYASendDynamicViewController.h"
#import "WYACameraCell.h"
#import "WYASendDynamicImageEditCell.h"

#import "WYASendDynamicViewModel.h"
#import "WYASendDynamicDraftModel.h"

#define CameraCell @"WYACameraCell"
#define EditCameraCell @"WYASendDynamicImageEditCell"

@interface WYASendDynamicViewController () <WYANavBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIView * textSuperView;
@property (nonatomic, strong) WYATextView * textView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, assign) BOOL allImage;
@property (nonatomic, strong) WYASendDynamicDraftModel * model;
@end

@implementation WYASendDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavBar];
    [self configUI];
    [self getHistoryDataSource];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark ======= Private Method
- (void)configNavBar {
    self.navTitle               = @"发布动态";
    self.navBar.delegate        = self;
    self.navBar.navTitleColor   = [UIColor whiteColor];
    self.navBar.backgroundColor = [UIColor blackColor];
    [self.navBar wya_goBackButtonWithTitle:@"取消"
                               normalColor:[UIColor wya_whiteColor]
                          highlightedColor:nil];
    [self.navBar wya_addRightNavBarButtonWithNormalTitle:@[ @"发布" ]
                                             normalColor:@[ [UIColor whiteColor] ]
                                        highlightedColor:nil];
}

- (void)configUI {
    self.view.backgroundColor = [UIColor wya_bgColor];
    [self.view addSubview:self.textSuperView];
    [self.textSuperView addSubview:self.textView];
    [self.view addSubview:self.collectionView];
}

- (void)getHistoryDataSource {
    self.model = [WYASendDynamicViewModel lookupSendDynamicDraft];
    if (self.model) {
        self.textView.text = self.model.text;
        self.dataSource = [NSKeyedUnarchiver unarchiveObjectWithData:self.model.imageDatas];
        [self.collectionView reloadData];
        [self changeCollectionViewFrame];
    }
}

- (void)changeCollectionViewFrame{
    CGFloat height = (ScreenWidth - 40 * SizeAdapter) / 3;
    CGFloat row = (self.dataSource.count + (self.allImage ? 0 : 1)) / 3;
    CGFloat column = (self.dataSource.count + (self.allImage ? 0 : 1)) % 3;
    if (row > 0) {
        if (column > 0) {
            self.collectionView.cmam_height = (height + 20 * SizeAdapter) * (row + 1);
        } else {
            self.collectionView.cmam_height = (height + 20 * SizeAdapter) * row;
        }
    } else {
        self.collectionView.cmam_height = height + 20 * SizeAdapter;
    }

}

#pragma mark ======= WYANavBarDelegate
- (void)wya_goBackPressed:(UIButton *)sender {
    WYAAlertController * alert =
    [WYAAlertController wya_alertWithTitle:@"是否保存草稿？"
                                   Message:nil
                          AlertLayoutStyle:WYAAlertLayoutStyleHorizontal];
    alert.backgroundButton.enabled = NO;
    alert.presentStyle             = WYAPopupPresentStyleBounce;
    alert.dismissStyle             = WYAPopupDismissStyleShrink;
    // 创建 action
    WYAAlertAction * defaultAction =
    [WYAAlertAction wya_actionWithTitle:@"不保留"
                                  style:WYAAlertActionStyleCancel
                                handler:^{
                                    [WYASendDynamicViewModel deleteSendDynamicDraft];
                                    [self.navigationController popViewControllerAnimated:YES];
    }];

    WYAAlertAction * cancelAction =
    [WYAAlertAction wya_actionWithTitle:@"保留"
                                  style:WYAAlertActionStyleDefault
                                handler:^{
                                    BOOL isSuccess;
                                    if (self.model) {
                                        isSuccess = [WYASendDynamicViewModel updateSendDynamicDraftWithText:self.textView.text images:self.dataSource];
                                    } else {
                                        isSuccess = [WYASendDynamicViewModel saveSendDynamicDraftWithText:self.textView.text images:self.dataSource];
                                    }
                                    if (isSuccess) {
                                        [self.navigationController popViewControllerAnimated:YES];
                                    } else {
                                        [UIView wya_showBottomToastWithMessage:@"保存失败"];
                                    }
    }];

    [alert wya_addAction:defaultAction];
    [alert wya_addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

}

/// 自定义右侧按钮点击事件
- (void)wya_rightBarButtonItemPressed:(UIButton *)sender {
}

#pragma mark ======= UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count + (self.allImage ? 0 : 1);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.dataSource.count) {
        WYACameraCell * cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:CameraCell
                                                  forIndexPath:indexPath];
        return cell;
    } else {
        WYASendDynamicImageEditCell * cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:EditCameraCell
                                                  forIndexPath:indexPath];
        cell.imgView.image               = self.dataSource[indexPath.item];
        cell.editBlock           = ^{
            [self.dataSource removeObjectAtIndex:indexPath.item];
            self.allImage = NO;
            [collectionView reloadData];
            [self changeCollectionViewFrame];
        };
        return cell;
    }
}

#pragma mark ======= UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (ScreenWidth - 40 * SizeAdapter) / 3;
    return CGSizeMake(width, width);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10 * SizeAdapter, 10 * SizeAdapter, 10 * SizeAdapter, 10 * SizeAdapter);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                                      layout:(UICollectionViewLayout *)collectionViewLayout
    minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0 * SizeAdapter;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                                 layout:(UICollectionViewLayout *)collectionViewLayout
    minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10 * SizeAdapter;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.item == self.dataSource.count) {

        WYAAlertController * alert = [WYAAlertController wya_alertSheetWithTitle:@"" Message:@""];
        WeakSelf(weakSelf);
        WYAAlertAction * photoAction = [WYAAlertAction wya_actionWithTitle:@"相机"
                                                                     style:WYAAlertActionStyleDefault
                                                                   handler:^{
            WYACameraViewController * camera =
                [[WYACameraViewController alloc] initWithType:WYACameraTypeImage
                                            cameraOrientation:WYACameraOrientationFront];
            camera.preset    = WYAVideoPresetHigh;
            camera.takePhoto = ^(UIImage * photo, NSString * imagePath) {
                [self.dataSource insertObject:photo atIndex:0];
                if (self.dataSource.count == 9) {
                    self.allImage = YES;
                }
                [self.collectionView reloadData];
                [self changeCollectionViewFrame];
            };
            camera.takeVideo = ^(NSString * videoPath) {

            };
            [weakSelf presentViewController:camera animated:YES completion:nil];

        }];

        WYAAlertAction * ablumAction = [WYAAlertAction wya_actionWithTitle:@"相册"
                                                                     style:WYAAlertActionStyleDefault
                                                                   handler:^{

            WYAPhotoBrowser * photo =
                [[WYAPhotoBrowser alloc] initWithMaxCount:9 - self.dataSource.count
                                         photoBrowserType:WYAPhotoBrowserTypePhoto];
            photo.callBackBlock = ^(NSMutableArray * _Nonnull media) {
                [self.dataSource addObjectsFromArray:media];
                if (self.dataSource.count == 9) {
                    self.allImage = YES;
                }
                [self.collectionView reloadData];
                [self changeCollectionViewFrame];
            };
            [weakSelf presentViewController:photo animated:YES completion:nil];

        }];

        [alert wya_addAction:photoAction];
        [alert wya_addAction:ablumAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark ======= Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = ({
            UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection              = UICollectionViewScrollDirectionVertical;
            layout.headerReferenceSize          = CGSizeMake(ScreenWidth, 0);

            CGFloat object_x      = 0;
            CGFloat object_y      = self.textSuperView.cmam_bottom;
            CGFloat object_width  = self.view.cmam_width;
            CGFloat object_height = (ScreenWidth - 40 * SizeAdapter) / 3 + 20 * SizeAdapter;
            CGRect object_rect    = CGRectMake(object_x, object_y, object_width, object_height);

            UICollectionView * object = [[UICollectionView alloc] initWithFrame:object_rect collectionViewLayout:layout];
            object.delegate           = self;
            object.dataSource         = self;
            object.backgroundColor    = [UIColor wya_whiteColor];
            [object registerNib:[UINib nibWithNibName:@"WYACameraCell" bundle:nil] forCellWithReuseIdentifier:CameraCell];
            [object registerNib:[UINib nibWithNibName:@"WYASendDynamicImageEditCell" bundle:nil] forCellWithReuseIdentifier:EditCameraCell];
            object;
        });
    }
    return _collectionView;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = ({
            NSMutableArray * object = [[NSMutableArray alloc] init];
            object;
        });
    }
    return _dataSource;
}
- (WYATextView *)textView {
    if (!_textView) {
        _textView = ({

            CGFloat object_x = 10 * SizeAdapter;
            CGFloat object_y = 10 * SizeAdapter;
            CGFloat object_width = self.view.cmam_width - 20 * SizeAdapter;
            CGFloat object_height = 100 * SizeAdapter;
            CGRect object_rect = CGRectMake(object_x, object_y,  object_width, object_height);

            WYATextView * object = [[WYATextView alloc] initWithFrame:object_rect];
            [object wya_PlaceHoldString:@"请输入文字"
                         PlaceHoldColor:[UIColor grayColor]
                          PlaceHoldFont:15.f];
            object.showTitle         = NO;
            object.textViewWordsCount = 500;
            object.textViewMaxHeight = 100;
            object;
        });
    }
    return _textView;
}

- (UIView *)textSuperView{
    if(!_textSuperView){
        _textSuperView = ({
            CGFloat object_x = 0;
            CGFloat object_y = WYATopHeight;
            CGFloat object_width = ScreenWidth;
            CGFloat object_height = 110 * SizeAdapter;
            CGRect object_rect = CGRectMake(object_x, object_y,  object_width, object_height);
            UIView * object = [[UIView alloc]initWithFrame:object_rect];
            object.backgroundColor = [UIColor wya_whiteColor];
            object;
       });
    }
    return _textSuperView;
}
@end
