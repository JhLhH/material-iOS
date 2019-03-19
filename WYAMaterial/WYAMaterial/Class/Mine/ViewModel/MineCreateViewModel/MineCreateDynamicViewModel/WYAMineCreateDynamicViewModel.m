//
//  WYAMineCreateDynamicViewModel.m
//  WYAMaterial
//
//  Created by 李世航 on 2019/3/18.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

#import "WYAMineCreateDynamicViewModel.h"
#import "WYAMineCreateDynamicModel.h"
@implementation WYAMineCreateDynamicViewModel
- (NSArray *)testSource {
//    return @[[self bbbWithNumber:2
//                            name:@"哈哈"
//                           level:@"总部"
//                            time:@"2019-03-14 10:00"
//                         content:@"今天添加了首页界面，现在数据是个人模拟的，不是真实数据现在数据是个人模拟的，不是真实数据"
//                         forward:NO
//                      collection:NO
//                        comments:6],];
    return @[
             [self bbbWithNumber:1
                            name:@"哈哈"
                           level:@"总部"
                            time:@"2019-03-14 10:00"
                         content:@"今天添加了首页界面，现在数据是个人模拟的，不是真实数据"
                         forward:NO
                      collection:NO
                        comments:1
                    reviewStatus:1],
             [self bbbWithNumber:2
                            name:@"哈哈"
                           level:@"总部"
                            time:@"2019-03-14 10:00"
                         content:@"今天添加了首页界面，现在数据是个人模拟的，不是真实数据"
                         forward:NO
                      collection:NO
                        comments:1
                    reviewStatus:0],
             [self bbbWithNumber:6
                            name:@"呵呵"
                           level:@"代理"
                            time:@"2019-03-14 11:00"
                         content:@"今天添加了首页界面，现在数据是个人模拟的，不是真实数据。今天添加了首页界面，现在数据是个人模拟的，不是真实数据。今天添加了首页界面，现在数据是个人模拟的，不是真实数据。"
                         forward:YES
                      collection:YES
                        comments:5
                    reviewStatus:2],
             [self bbbWithNumber:4
                            name:@"嘿嘿"
                           level:@"总部"
                            time:@"2019-03-14 12:00"
                         content:@"今天添加了首页界面，现在数据是个人模拟的，不是真实数据。今天添加了首页界面，现在数据是个人模拟的，不是真实数据。"
                         forward:YES
                      collection:NO
                        comments:3
                    reviewStatus:0],
             [self bbbWithNumber:3
                            name:@"起个名字真难"
                           level:@"总部"
                            time:@"2019-03-14 13:00"
                         content:@"今天添加了首页界面，现在数据是个人模拟的，不是真实数据。今天添加了首页界面，不是真实数据。"
                         forward:NO
                      collection:YES
                        comments:2
                    reviewStatus:1],
             [self bbbWithNumber:5
                            name:@"大力出奇迹"
                           level:@"代理"
                            time:@"2019-03-14 14:00"
                         content:@"今天添加了首页界面，现在数据是个人模拟的，不是真首页界面，现在数据是个人模拟的，不是真实数据。"
                         forward:YES
                      collection:NO
                        comments:9
                    reviewStatus:2],
             [self bbbWithNumber:8
                            name:@"随便写写吧"
                           level:@"代理"
                            time:@"2019-03-14 20:00"
                         content:@"今天添加了首页界面，现在数据是个人模拟的，不是真首页界面，现在数据是个人模拟的，不是真实数据。"
                         forward:YES
                      collection:NO
                        comments:3
                    reviewStatus:1],];
}

- (WYAMineCreateDynamicImageModel *)aaa{
    WYAMineCreateDynamicImageModel * imageModel = [[WYAMineCreateDynamicImageModel alloc]init];
    imageModel.imageUrl = @"";
    return imageModel;
}

- (WYAMineCreateDynamicCommentsModel *)ccc{
    WYAMineCreateDynamicCommentsModel * model = [[WYAMineCreateDynamicCommentsModel alloc]init];
    model.comments = @"这是评论,这是及房价地价结构激动机构及东莞为奇偶电视剧佛为加大搜附近偶滴神覅京东就感觉如果今日任务企鹅窝hi去很符合方式";
    model.personName = @"xxx";
    return model;
}

- (WYAMineCreateDynamicModel *)bbbWithNumber:(int)number
                                name:(NSString *)name
                               level:(NSString *)level
                                time:(NSString *)time
                             content:(NSString *)content
                             forward:(BOOL)forward
                          collection:(BOOL)collection
                                    comments:(int)comments
                                reviewStatus:(int)status{
    WYAMineCreateDynamicModel * model = [[WYAMineCreateDynamicModel alloc]init];
    model.userName = name;
    model.userLevel = level;
    model.time = time;
    model.content = content;
    NSMutableArray * array = [NSMutableArray array];
    for (NSInteger index = 0; index<number; index++) {
        WYAMineCreateDynamicImageModel * imageModel = [self aaa];
        [array addObject:imageModel];
    }
    model.urls = [array copy];
    model.forwarding = forward;
    model.collection = arc4random() % 101;
    model.person = arc4random() % 101;

    NSMutableArray * arr = [NSMutableArray array];
    for (NSInteger i = 0; i<comments; i++) {
        WYAMineCreateDynamicCommentsModel * imageModel = [self ccc];
        [arr addObject:imageModel];
    }
    model.comments = [arr copy];
    model.reviewStatus = status;
    return model;
}
@end
