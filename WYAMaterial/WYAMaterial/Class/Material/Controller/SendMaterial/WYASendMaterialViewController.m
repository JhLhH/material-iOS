//
//  WYASendMaterialViewController.m
//  WYAMaterial
//
//  Created by 李俊恒 on 2019/3/21.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYASendMaterialViewController.h"
#import "WYAMaterialCameraCell.h"
#import "WYASendMaterialImageEditCell.h"
#import "WYAMaterialLabelView.h"



#define CameraCell @"WYAMaterialCameraCell"

#define EditCameraCell @"WYASendMaterialImageEditCell"

@interface WYASendMaterialViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIView * textSuperView;
@property (nonatomic, strong) WYATextView * textView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, assign) BOOL allImage;
@property (nonatomic, strong) WYAMaterialLabelView * associatedLabelView;// 关联标签
@end

@implementation WYASendMaterialViewController
#pragma mark ======= LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.materialType == MaterialTypeCreate) {
        self.navTitle = @"新建";
    }else{
        self.navTitle = @"编辑";
    }
    [self.navBar wya_addLeftNavBarButtonWithNormalTitle:@[@"取消"] normalColor:@[[UIColor wya_textWhitColorl]] highlightedColor:@[[UIColor wya_textGrayColor]]];
    [self.navBar wya_addRightNavBarButtonWithNormalTitle:@[@"发布"] normalColor:@[[UIColor wya_textWhitColorl]] highlightedColor:@[[UIColor wya_textGrayColor]]];

    [self.view addSubview:self.textSuperView];
    [self.textSuperView addSubview:self.textView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.associatedLabelView];
    [self.associatedLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.equalTo(self.collectionView.mas_bottom).offset(8*SizeAdapter);
        make.height.mas_equalTo(55*SizeAdapter);
    }];


}
- (void)wya_customLeftBarButtonItemPressed:(UIButton *)sender{
    if (self.materialType == MaterialTypeCreate) {
        // 在点击取消按钮时需要确认是否保存草稿
        [self createPop];
    }else{
        // 是否放弃编辑
    }
}
- (void)wya_customrRightBarButtonItemPressed:(UIButton *)sender{
    
}
- (void)createPop{
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

                                    [self.navigationController popViewControllerAnimated:YES];
                                }];

    WYAAlertAction * cancelAction =
    [WYAAlertAction wya_actionWithTitle:@"保留"
                                  style:WYAAlertActionStyleDefault
                                handler:^{
//                                    BOOL isSuccess;
//                                    if (self.model) {
//                                        isSuccess = [WYASendDynamicViewModel updateSendDynamicDraftWithText:self.textView.text images:self.dataSource];
//                                    } else {
//                                        isSuccess = [WYASendDynamicViewModel saveSendDynamicDraftWithText:self.textView.text images:self.dataSource];
//                                    }
                                    [UIView wya_showBottomToastWithMessage:@"保存失败"];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        [self.navigationController popViewControllerAnimated:YES];
                                    });
                                }];

    [alert wya_addAction:defaultAction];
    [alert wya_addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark ======= Private Method
- (void)changeCollectionViewFrame {
    CGFloat height = (ScreenWidth - 40 * SizeAdapter) / 3;
    CGFloat row    = (self.dataSource.count + (self.allImage ? 0 : 1)) / 3;
    CGFloat column = (self.dataSource.count + (self.allImage ? 0 : 1)) % 3;
    if (row > 0) {
        if (column > 0) {
            self.collectionView.cmam_height = (height + 20 * SizeAdapter) * (row + 1) + 20 * SizeAdapter;
        } else {
            self.collectionView.cmam_height = (height + 20 * SizeAdapter) * row + 20 * SizeAdapter;
        }
    } else {
        self.collectionView.cmam_height = height + 20 * SizeAdapter + 20 * SizeAdapter;
    }

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
        WYAMaterialCameraCell * cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:CameraCell
                                                  forIndexPath:indexPath];
        return cell;
    } else {
        WYASendMaterialImageEditCell * cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:EditCameraCell
                                                  forIndexPath:indexPath];
        cell.imgView.image = self.dataSource[indexPath.item];
        cell.imgView.contentMode = UIViewContentModeScaleAspectFill;
        cell.editBlock     = ^{
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

#pragma mark ======= Lazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = ({
            UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection              = UICollectionViewScrollDirectionVertical;
            layout.headerReferenceSize          = CGSizeMake(ScreenWidth, 0);

            CGFloat object_x      = 0;
            CGFloat object_y      = self.textSuperView.cmam_bottom;
            CGFloat object_width  = self.view.cmam_width;
            CGFloat object_height = (ScreenWidth - 40 * SizeAdapter) / 3 + 40 * SizeAdapter;
            CGRect object_rect    = CGRectMake(object_x, object_y, object_width, object_height);

            UICollectionView * object = [[UICollectionView alloc] initWithFrame:object_rect collectionViewLayout:layout];
            object.delegate           = self;
            object.dataSource         = self;
            object.backgroundColor    = [UIColor wya_whiteColor];
            [object registerNib:[UINib nibWithNibName:@"WYAMaterialCameraCell" bundle:nil] forCellWithReuseIdentifier:CameraCell];
            [object registerNib:[UINib nibWithNibName:@"WYASendMaterialImageEditCell" bundle:nil] forCellWithReuseIdentifier:EditCameraCell];
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

            CGFloat object_x      = 10 * SizeAdapter;
            CGFloat object_y      = 10 * SizeAdapter;
            CGFloat object_width  = self.view.cmam_width - 20 * SizeAdapter;
            CGFloat object_height = 100 * SizeAdapter;
            CGRect object_rect    = CGRectMake(object_x, object_y, object_width, object_height);

            WYATextView * object = [[WYATextView alloc] initWithFrame:object_rect];
            [object wya_PlaceHoldString:@"请输入文字"
                         PlaceHoldColor:[UIColor grayColor]
                          PlaceHoldFont:15.f];
            object.showTitle          = NO;
            object.textViewWordsCount = 500;
            object.textViewMaxHeight  = 100;
            object;
        });
    }
    return _textView;
}

- (UIView *)textSuperView {
    if (!_textSuperView) {
        _textSuperView = ({
            CGFloat object_x       = 0;
            CGFloat object_y       = WYATopHeight;
            CGFloat object_width   = ScreenWidth;
            CGFloat object_height  = 110 * SizeAdapter;
            CGRect object_rect     = CGRectMake(object_x, object_y, object_width, object_height);
            UIView * object        = [[UIView alloc] initWithFrame:object_rect];
            object.backgroundColor = [UIColor wya_whiteColor];
            object;
        });
    }
    return _textSuperView;
}

- (WYAMaterialLabelView *)associatedLabelView{
    if(!_associatedLabelView){
        _associatedLabelView = ({
            WYAMaterialLabelView * object = [[WYAMaterialLabelView alloc]init];
            object;
       });
    }
    return _associatedLabelView;
}
@end
