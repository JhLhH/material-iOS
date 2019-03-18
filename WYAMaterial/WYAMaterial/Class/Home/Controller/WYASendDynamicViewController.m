//
//  WYASendDynamicViewController.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/15.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYASendDynamicViewController.h"
#import "WYACameraCell.h"

#define CameraCell @"WYACameraCell"
#define EditCameraCell @"WYAEditCameraCell"

@interface WYASendDynamicViewController () <WYANavBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) WYATextView * textView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, assign) BOOL allImage;
@end

@implementation WYASendDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavBar];
    [self configUI];
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
    self.view.backgroundColor = [UIColor wya_whiteColor];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.collectionView];
}

#pragma mark ======= WYANavBarDelegate
- (void)wya_goBackPressed:(UIButton *)sender {

//    if (self.textView.text) {
//        WYAUserDefaultSetObjectForKey(self.textView.text, @"sendDynamicText")
//    }

    [self.navigationController popViewControllerAnimated:YES];
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
    if (self.allImage) {
        WYAEditCameraCell * cell =
            [collectionView dequeueReusableCellWithReuseIdentifier:EditCameraCell
                                                      forIndexPath:indexPath];
        return cell;
    } else {
        if (indexPath.item == self.dataSource.count) {
            WYACameraCell * cell =
                [collectionView dequeueReusableCellWithReuseIdentifier:CameraCell
                                                          forIndexPath:indexPath];
            return cell;
        } else {
            WYAEditCameraCell * cell =
                [collectionView dequeueReusableCellWithReuseIdentifier:EditCameraCell
                                                          forIndexPath:indexPath];
            return cell;
        }
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
    CGFloat width = (ScreenWidth - 50) / 4;
    return CGSizeMake(width, width);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10 * SizeAdapter, 10, 10 * SizeAdapter, 10);
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
    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
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

            };
            camera.takeVideo = ^(NSString * videoPath) {

            };
            [weakSelf presentViewController:camera animated:YES completion:nil];

        }];

        WYAAlertAction * ablumAction = [WYAAlertAction wya_actionWithTitle:@"相册"
                                                                     style:WYAAlertActionStyleDefault
                                                                   handler:^{

            WYAPhotoBrowser * photo =
                [[WYAPhotoBrowser alloc] initWithMaxCount:3
                                         photoBrowserType:WYAPhotoBrowserTypeAll];
            photo.callBackBlock = ^(NSMutableArray * _Nonnull media) {

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
            layout.headerReferenceSize          = CGSizeMake(ScreenWidth, 0 * SizeAdapter);

            CGFloat object_x      = 0;
            CGFloat object_y      = self.textView.cmam_bottom;
            CGFloat object_width  = self.view.cmam_width;
            CGFloat object_height = self.view.cmam_height - self.textView.cmam_bottom;
            CGRect object_rect    = CGRectMake(object_x, object_y, object_width, object_height);

            UICollectionView * object = [[UICollectionView alloc] initWithFrame:object_rect collectionViewLayout:layout];
            object.delegate           = self;
            object.dataSource         = self;
            object.backgroundColor    = [UIColor wya_whiteColor];
            [object registerNib:[UINib nibWithNibName:@"WYACameraCell" bundle:nil] forCellWithReuseIdentifier:CameraCell];
            [object registerClass:[WYAEditCameraCell class] forCellWithReuseIdentifier:EditCameraCell];
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

            CGFloat object_x = 10;
            CGFloat object_y = WYATopHeight + 20;
            CGFloat object_width = self.view.cmam_width - 20;
            CGFloat object_height = 100;
            CGRect object_rect = CGRectMake(object_x, object_y,  object_width, object_height);

            WYATextView * object = [[WYATextView alloc] initWithFrame:object_rect];
            [object wya_PlaceHoldString:@"请输入文字"
                         PlaceHoldColor:[UIColor grayColor]
                          PlaceHoldFont:15.f];
            object.showTitle         = NO;
            object.showWordsCount    = NO;
            object.textViewMaxHeight = 100;
            object;
        });
    }
    return _textView;
}
@end