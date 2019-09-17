//
//  GGAFNTools.m
//  GaoHeng
//
//  Created by hua on 16/8/16.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import "HYHttpTools.h"
#import "AppDelegate.h"

//#import "NSString+MD5Addition.h"
#import "MBProgressHUD+Add.h"
static HYHttpTools *tools = nil;
@implementation HYHttpTools

+(instancetype)shareHttpTools
{
    if (tools == nil) {
        static dispatch_once_t once_token;
        dispatch_once(&once_token, ^{
            tools = [[HYHttpTools alloc] init];
        });
    }
    return tools;
}

//#pragma mark 上传图片AFN
///**
// *  上传图片AFN
// */
//-(void)HY_setHttpToPhoto:(NSString *)url params:(NSDictionary *)params imageData:(NSData *)imageData passValue:(pushDict)value  error:(Error)Error{
//      NSString *tmpUrl = [NSString stringWithFormat:@"%@",url];
//    MBProgressHUD *hud =  [MBProgressHUD showMessag:@"正在加载"];
//    AFHTTPSessionManager *manager = [self managerWithBaseURL:YES];
//    [manager POST:tmpUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSLog(@"YYYYYYYYYYYYY------>照片上传大小:____>%lukb<______",[imageData length]/1000 );
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        // 设置日期格式
//        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        NSString *fileName = [formatter stringFromDate:[NSDate date]];
//        NSLog(@"请求网址:%@?%@iamge:%@",tmpUrl,params,fileName);
//        [formData appendPartWithFileData:imageData name:@"img" fileName:[NSString stringWithFormat:@"%@.png",fileName] mimeType:@"image/png"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [hud hideAnimated:YES];
//        [self datawithresponseObjectSuccess:responseObject passValue:^(NSDictionary *dict) {
//
//            value(dict);
//        } error:^(NSString *error) {
//            [MBProgressHUD showTipMessage:error];
//            Error(error);
//
//        } geturl:url];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [hud hideAnimated:YES];
//        [self datawithresponseObjectError:error.code error:error Error:^(NSString *error) {
//            [MBProgressHUD showTipMessage:error];
//            Error(error);
//        } geturl:url];
//    }];
//
//}
#pragma  mark 封装处理数据 返回字典
/**
 *  封装处理数据 返回字典
 */
-(void)HY_setHttpToJsonArray:(NSString *)url params:(id)params  type:(ASKTYPE)type isJson:(BOOL)isJson passValue:(pushArr)value error:(Error)Error{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *tmpUrl = [NSString stringWithFormat:@"%@",url];
        NSDictionary *param =  params;
        // 1.创建AFN管理者
        AFHTTPSessionManager *manager = [self managerWithBaseURL:isJson  ];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        NSLog(@"================请求开始=================\n");
        NSLog(@"请求网址:%@?%@",url,param);
        if (type == POST) {
            [manager POST:tmpUrl parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"%f",uploadProgress.fractionCompleted);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                // 请求成功, 通知调用者请求成功
                //            [hud hideAnimated:YES];
                [self datawithresponseObjectSuccess:responseObject passValue:^(NSMutableArray *array) {
                    value(array);
                } error:^(NSString *error) {
                    [MBProgressHUD showTipMessage:error];
                    Error(error);
                    
                } geturl:url];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //            [hud hideAnimated:YES];
                [self datawithresponseObjectError:error.code error:error Error:^(NSString *error) {
                    [MBProgressHUD showTipMessage:error];
                    Error(error);
                } geturl:url];
            }];
        }
        if (type == GET) {
            // 2.发送请求
            [manager GET:tmpUrl parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"%f",downloadProgress.fractionCompleted);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //            [hud hideAnimated:YES];
                [self datawithresponseObjectSuccess:responseObject passValue:^(NSMutableArray *array) {
                
                    value(array);
                } error:^(NSString *error) {
                    [MBProgressHUD showTipMessage:error];
                    Error(error);
                } geturl:url];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //            [hud hideAnimated:YES];
                [self datawithresponseObjectError:error.code error:error Error:^(NSString *error) {
                    [MBProgressHUD showTipMessage:error];
                    Error(error);
                    
                } geturl:url];
                
            }];
            
        }
    });
   
}
/**
 *
 */
-(AFHTTPSessionManager *)managerWithBaseURL:(BOOL)isJson{
    
    AFHTTPSessionManager *manager =nil;
    NSURL *url = [NSURL URLWithString:@""];
    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    //     [manager setSecurityPolicy:[self customSecurityPolicy]];
    if (isJson) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"Client-ID e98955b8b3ae269c7753f3714e41375d86f1b3ccad2be31309cf96645e18cd7f" forHTTPHeaderField:@"Authorization"];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",@"application/json", @"text/javascript",nil];

    return manager;
}

-(void)datawithresponseObjectSuccess:(id)responseObject passValue:(pushArr)value error:(Error)Error geturl:(NSString *)geturl {
    if (responseObject != 0) {

        id array = [self responseConfiguration:responseObject];
        if(array == nil){
            return;
        }
        NSLog(@"返回请求网址:%@\n返回信息:%@",geturl,array);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"===============请求结束================\n");

        if ([array isKindOfClass:[NSArray class]]&&[array count]>0){
            value(array);
        } else{
            Error(@"null");
        }
    }else  {
        NSString * err = @"数据为空" ;
        Error(err);
    }
    
}
-(void)datawithresponseObjectError:(NSInteger)code error:(NSError *)error Error:(Error)Error geturl:(NSString *)geturl{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    NSLog(@"返回请求网址:%@",geturl);
    NSLog(@">>>>%ld通知调用者请求失败的%@" ,error.code,error );
    if (code == -1011) {  Error(@"服务器正在紧急修理,请稍后试一下吧~");
    }else if (code == -1004) {  Error(@"无法连接服务器,请稍后试一下吧~");
    }else{  Error(@"网络连接失败"); }
}
-(id)responseConfiguration:(id)responseObject{
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    if (string == nil) {
        return nil;
    }
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return array;
}
 


@end
