//
//  WYAMacros.h
//  WYA_iOS_Scaffold
//
//  Created by 李俊恒 on 2018/7/3.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#ifndef WYAMacros_h
#define WYAMacros_h

/**
 Library/Caches 文件路径
 */
#define WYAFilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])

/**
 获取temp
 */
#define WYAPathTemp NSTemporaryDirectory()
/**
 获取沙盒 Document
*/
#define WYAPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
/**获取沙盒 Cache*/
#define WYAPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
/**edit the plist*/
#define PLIST_TICKET_INFO_EDIT [NSHomeDirectory() stringByAppendingString:@"/Documents/data.plist"]
/** 空字符串*/
#define WYAEmptyStr @""
/**字符串是否为空*/
#define WYAStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO)
/**数组是否为空*/
#define WYAArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
/**字典是否为空*/
#define WYADictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
/**是否是空对象*/
#define WYAObjectIsEmpty(_object) (_object == nil || [_object isKindOfClass:[NSNull class]] || ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) || ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0)) ? YES : NO

//---------------------------------------------------------------

/** the saving objects      存储对象 */
#define WYAUserDefaultSetObjectForKey(__VALUE__, __KEY__)                           \
    {                                                                               \
        [[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__]; \
        [[NSUserDefaults standardUserDefaults] synchronize];                        \
    }
#define WYAUserDefaultSetBoolForKey(__VALUE__, __KEY__)                           \
    {                                                                             \
        [[NSUserDefaults standardUserDefaults] setBool:__VALUE__ forKey:__KEY__]; \
        [[NSUserDefaults standardUserDefaults] synchronize];                      \
    }

/** get the saved objects       获得存储的对象 */
#define WYAUserDefaultObjectForKey(__KEY__) [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]
#define WYAUserDefaultBoolForKey(__KEY__) [[NSUserDefaults standardUserDefaults] boolForKey:__KEY__]

/** delete objects      删除对象 */
#define WYAUserDefaultRemoveObjectForKey(__KEY__)                           \
    {                                                                       \
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__]; \
        [[NSUserDefaults standardUserDefaults] synchronize];                \
    }

#endif /* WYAMacros_h */
