//
//  BaseNetWorking.m
//  WYAiOSEnv
//
//  Created by 李世航 on 2018/7/11.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

#import "BaseNetWorking.h"

//默认网络请求时间
static const NSUInteger kDefaultTimeoutInterval = 6;

@implementation BaseNetWorking

+ (AFHTTPSessionManager *)AFManager {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    // 超过时间
    manager.requestSerializer.timeoutInterval = kDefaultTimeoutInterval;

    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式

    // 声明获取到的数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    //        manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"text/xml", nil];
    return manager;
}

+ (void)GetWithUrl:(NSString *)urlString
            Params:(NSMutableDictionary *)params
           Success:(Success)success
              Fail:(Fail)fail {
    AFHTTPSessionManager * manager = [self AFManager];

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * token              = [userDefaults objectForKey:@"access_token"];
    NSMutableDictionary * dic     = [NSMutableDictionary dictionaryWithDictionary:params];
    if (token) {
        [dic setObject:token forKey:@"access_token"];
    }

    [manager GET:urlString
        parameters:dic
        progress:^(NSProgress * _Nonnull downloadProgress) {

        }
        success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {

            id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(jsonObj);

        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            fail(error.localizedDescription);

        }];
}

+ (void)PostWithUrl:(NSString *)urlString
             Params:(NSMutableDictionary *)params
            Success:(Success)success
               Fail:(Fail)fail {
    AFHTTPSessionManager * manager = [self AFManager];

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * token              = [userDefaults objectForKey:@"access_token"];
    NSMutableDictionary * dic     = [NSMutableDictionary dictionaryWithDictionary:params];
    if (token) {
        [dic setObject:token forKey:@"access_token"];
    }

    [manager POST:urlString
        parameters:dic
        progress:^(NSProgress * _Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {

            id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

            success(jsonObj);

        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            fail(error.localizedDescription);

        }];
}

+ (void)UploadImageWithUrl:(NSString *)urlString
                    params:(NSMutableDictionary *)params
                    Images:(NSArray<UIImage *> *)images
                ImageNames:(NSArray<NSString *> *)imageNames
                 ImageType:(ImageType)type
     ImageCompressionRatio:(float)ratio
                  progress:(Progress)progress
                   Success:(Success)success
                      Fail:(Fail)fail {
    if (images.count == 0) {
        fail(@"上传图片个数不能小于1个");
        return;
    }

    AFHTTPSessionManager * manager = [self AFManager];

    [manager POST:urlString
        parameters:params
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {

            for (NSInteger i = 0; i < images.count; i++) {
                UIImage * image = images[i];

                NSData * data;
                NSString * imageType;
                switch (type) {
                    case imageForPNG:
                        data      = UIImagePNGRepresentation(image);
                        imageType = @"image/png";
                        break;
                    case imageForJPEG:
                        data      = UIImageJPEGRepresentation(image, ratio);
                        imageType = @"image/jpeg";
                        break;
                    default:
                        break;
                }

                [formData appendPartWithFileData:data name:@"Filedata" fileName:imageNames[i] mimeType:imageType];
            }

        }
        progress:^(NSProgress * _Nonnull uploadProgress) {

            progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);

        }
        success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {

            id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

            success(jsonObj);

        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            fail(error.localizedDescription);

        }];
}

+ (void)UploadVideoWithUrl:(NSString *)urlString
                    Params:(NSMutableDictionary *)params
                VideoPaths:(NSArray *)videoPaths
                VideoNames:(NSArray *)videoNames
                  progress:(Progress)progress
                   Success:(Success)success
                      Fail:(Fail)fail {
    if (videoPaths.count == 0) {
        fail(@"上传视频个数不能小于1个");
        return;
    }

    AFHTTPSessionManager * manager = [self AFManager];

    [manager POST:urlString
        parameters:params
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {

            for (NSInteger i = 0; i < videoPaths.count; i++) {
                NSString * path = videoPaths[i];

                NSError * error;

                [formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:@"Filedata" fileName:videoNames[i] mimeType:@"application/octet-stream" error:&error];
                if (error) {
                    fail(error.localizedDescription);
                    return;
                }
            }

        }
        progress:^(NSProgress * _Nonnull uploadProgress) {

            progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);

        }
        success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {

            id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

            success(jsonObj);

        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            fail(error.localizedDescription);

        }];
}

+ (void)UploadFileWithUrl:(NSString *)urlString
                   Params:(NSMutableDictionary *)params
                FilePaths:(NSArray *)filePaths
                FileNames:(NSArray *)fileNames
                 progress:(Progress)progress
                  Success:(Success)success
                     Fail:(Fail)fail {
    if (filePaths.count == 0) {
        fail(@"上传文件个数不能小于1个");
        return;
    }

    AFHTTPSessionManager * manager = [self AFManager];

    [manager POST:urlString
        parameters:params
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {

            for (NSInteger i = 0; i < filePaths.count; i++) {
                NSString * path = filePaths[i];

                NSError * error;

                [formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:@"Filedata" fileName:fileNames[i] mimeType:@"application/octet-stream" error:&error];
                if (error) {
                    fail(error.localizedDescription);
                    return;
                }
            }

        }
        progress:^(NSProgress * _Nonnull uploadProgress) {

            progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);

        }
        success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {

            id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

            success(jsonObj);

        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            fail(error.localizedDescription);

        }];
}

+ (NSURLSessionDownloadTask *)DownloadFileWithUrl:(NSString *)urlString
                                           Params:(NSMutableDictionary *)params
                                         FilePath:(NSString *)filePath
                                         progress:(Progress)progress
                                          Success:(Success)success
                                             Fail:(Fail)fail {
    AFHTTPSessionManager * manager          = [self AFManager];
    urlString                               = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSURLRequest * reuqest                  = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDownloadTask * downloadTask = [manager downloadTaskWithRequest:reuqest
        progress:^(NSProgress * _Nonnull downloadProgress) {
            float number = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
            NSLog(@"number==%f", number);
            progress(number);

        }
        destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            return [NSURL fileURLWithPath:filePath];
        }
        completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {

            NSLog(@"jsonobj==%@", response);
            NSLog(@"error==%@", error);
            NSLog(@"filep==%@", filePath);
            if (error) {
                fail(@"下载失败");
            } else {
                success(@"下载成功");
            }

        }];

    return downloadTask;
}
@end
