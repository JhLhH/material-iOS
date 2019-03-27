//
//  WYAViewSettingModel.h
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/27.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAViewSettingModel : NSObject

extern const CGFloat showButtonFont;

// 头像
extern const CGFloat userHeaderWidth;
extern const CGFloat userHeaderLeft;
extern const CGFloat userHeaderTop;
extern const CGFloat userHeaderCornerRadius;
extern const CGFloat userHeaderBorderWidth;

// 昵称
extern const CGFloat userNameLabelLeft   ;
extern const CGFloat userNameLabelTop    ;
extern const CGFloat userNameLabelWidth  ;
extern const CGFloat userNameLabelHeight ;
extern const CGFloat userNameLabelFont   ;

// 层级图片
extern const CGFloat userLevelImageViewTop   ;
extern const CGFloat userLevelImageViewWidth  ;
extern const CGFloat userLevelImageViewHeight ;

// 层级
extern const CGFloat userLevelLabelLeft ;
extern const CGFloat userLevelLabelRight ;
extern const CGFloat userLevelLabelHeight;
extern const CGFloat userLevelLabelFont ;

// 转发
extern const CGFloat forwardingButtonRight  ;
extern const CGFloat forwardingButtonWidth  ;
extern const CGFloat forwardingButtonHeight ;
extern const CGFloat forwardingButtonSpace  ;
extern const CGFloat forwardingButtonFont   ;

// 发布内容
extern const CGFloat userReleaseContentLabelTop ;
extern const CGFloat userReleaseContentLabelRight;
extern const CGFloat userReleaseContentLabelNormalHeight ;
extern const CGFloat userReleaseContentLabelFont;
extern const CGFloat userReleaseContentLabelPadding ;

// 全文按钮
extern const CGFloat showButtonTop ;
extern const CGFloat showButtonWidth ;
extern const CGFloat showButtonHeight ;
extern const CGFloat showButtonFont ;

// 用户发布图片父视图
extern const CGFloat userReleaseImagesViewTop ;
extern const CGFloat userReleaseImagesViewRight ;

// 每个图片的设置
extern const CGFloat releaseImageCornerRadius ;

// 发布时间
extern const CGFloat userReleaseTimeLabelTop ;
extern const CGFloat userReleaseTimeLabelBottom ;
extern const CGFloat userReleaseTimeLabelWidth ;
extern const CGFloat userReleaseTimeLabelHeight ;
extern const CGFloat userReleaseTimeLabelFont ;

// 评论
extern const CGFloat commentsButtonLeft ;
extern const CGFloat commentsButtonWidth ;
extern const CGFloat commentsButtonHeight ;
extern const CGFloat commentsButtonFont ;
extern const CGFloat commentsButtonSpace ;

// 收藏
extern const CGFloat collectionButtonLeft ;
extern const CGFloat collectionButtonWidth ;
extern const CGFloat collectionButtonHeight ;
extern const CGFloat collectionButtonFont ;
extern const CGFloat collectionButtonSpace ;

// 点赞
extern const CGFloat praiseButtonLeft ;
extern const CGFloat praiseButtonWidth ;
extern const CGFloat praiseButtonHeight ;
extern const CGFloat praiseButtonFont ;
extern const CGFloat praiseButtonSpace ;

// 灰色父视图
extern const CGFloat bgViewLeft ;
extern const CGFloat bgViewRight ;

// 更多评论
extern const CGFloat showCommentsButtonHeight ;

// 单个评论
extern const CGFloat onlyOneCommentsTop ;
extern const CGFloat singleCommentsTop ;
extern const CGFloat singleCommentsLeft ;
extern const CGFloat singleCommentsHeight ;
extern const CGFloat singleCommentsFont ;

@end

NS_ASSUME_NONNULL_END
