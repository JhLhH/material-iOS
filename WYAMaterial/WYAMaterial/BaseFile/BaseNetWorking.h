//
//  BaseNetWorking.h
//  WYAiOSEnv
//
//  Created by 李世航 on 2018/7/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

/**
 *  在Get、Post请求中默认从NSUserDefaults取字段名为@"access_token"的值作为请求参数中的token上传，
 *  上传字段名为@"access_token"，有需要可以自行更改
 */

/**
     常见的MIME类型(通用型)：
     超文本标记语言文本 .html text/html
     xml文档 .xml text/xml
     XHTML文档 .xhtml application/xhtml+xml
     普通文本 .txt text/plain
     RTF文本 .rtf application/rtf
     PDF文档 .pdf application/pdf
     Microsoft Word文件 .word application/msword
     PNG图像 .png image/png
     GIF图形 .gif image/gif
     JPEG图形 .jpeg,.jpg image/jpeg
     au声音文件 .au audio/basic
     MIDI音乐文件 mid,.midi audio/midi,audio/x-midi
     RealAudio音乐文件 .ra, .ram audio/x-pn-realaudio
     MPEG文件 .mpg,.mpeg video/mpeg
     AVI文件 .avi video/x-msvideo
     GZIP文件 .gz application/x-gzip
     TAR文件 .tar application/x-tar
     任意的二进制数据 application/octet-stream
 */

#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ImageType) {
    imageForPNG,
    imageForJPEG,
};

typedef void (^Success)(id data);

typedef void (^Fail)(NSString * errorDes);

typedef void (^Progress)(float progress);

@interface BaseNetWorking : NSObject

/**
 Get请求
 
 @param urlString URL
 @param params 参数
 @param success 成功
 @param fail 失败
 */
+ (void)GetWithUrl:(NSString *)urlString
            Params:(NSMutableDictionary *)params
           Success:(Success)success
              Fail:(Fail)fail;

/**
 Post请求
 
 @param urlString URL
 @param params 参数
 @param success 成功
 @param fail 失败
 */
+ (void)PostWithUrl:(NSString *)urlString
             Params:(NSMutableDictionary *)params
            Success:(Success)success
               Fail:(Fail)fail;

/**
 上传图片

 @param urlString URL（如果需要拼接，请在外部把url拼接好再传入）
 @param params 参数
 @param images 图片数组
 @param imageNames 图片要上传时指定的名字
 @param type 图片要压缩类型
 @param ratio 如果图片压缩指定为JPEG方式，请指定压缩比例，否则忽略该参数
 @param progress 上传进度
 @param success 成功
 @param fail 失败
 */
+ (void)UploadImageWithUrl:(NSString *)urlString
                    params:(NSMutableDictionary *)params
                    Images:(NSArray<UIImage *> *)images
                ImageNames:(NSArray<NSString *> *)imageNames
                 ImageType:(ImageType)type
     ImageCompressionRatio:(float)ratio
                  progress:(Progress)progress
                   Success:(Success)success
                      Fail:(Fail)fail;

/**
 上传视频

 @param urlString URL（如果需要拼接，请在外部把url拼接好再传入）
 @param params 参数
 @param videoPaths 视频路径数组
 @param videoNames 视频上传时指定的名字
 @param progress 上传进度（如果想要获得每个上传进度，数组个数请传一个）
 @param success 成功
 @param fail 失败
 */
+ (void)UploadVideoWithUrl:(NSString *)urlString
                    Params:(NSMutableDictionary *)params
                VideoPaths:(NSArray *)videoPaths
                VideoNames:(NSArray *)videoNames
                  progress:(Progress)progress
                   Success:(Success)success
                      Fail:(Fail)fail;

/**
 上传文件（图片，视频也属于文件的一种）

 @param urlString URL（如果需要拼接，请在外部把url拼接好再传入）
 @param params 参数
 @param filePaths 文件路径数组
 @param fileNames 上传文件名
 @param progress 上传进度（如果想要获得每个上传进度，数组个数请传一个）
 @param success 成功
 @param fail 失败
 */
+ (void)UploadFileWithUrl:(NSString *)urlString
                   Params:(NSMutableDictionary *)params
                FilePaths:(NSArray *)filePaths
                FileNames:(NSArray *)fileNames
                 progress:(Progress)progress
                  Success:(Success)success
                     Fail:(Fail)fail;

/**
 下载文件

 @param urlString 路径
 @param params 参数
 @param filePath 下载到本地地址
 @param progress 进度
 @param success 成功
 @param fail 失败
 @return 下载管理器
 */
+ (NSURLSessionDownloadTask *)DownloadFileWithUrl:(NSString *)urlString
                                           Params:(NSMutableDictionary *)params
                                         FilePath:(NSString *)filePath
                                         progress:(Progress)progress
                                          Success:(Success)success
                                             Fail:(Fail)fail;
@end
