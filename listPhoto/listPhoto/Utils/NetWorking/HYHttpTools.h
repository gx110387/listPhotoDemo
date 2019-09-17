//
//  GGAFNTools.h
//  GaoHeng
//
//  Created by hua on 16/8/16.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef NS_ENUM(NSUInteger, ASKTYPE) {
    GET,
    POST
};
//typedef void(^pushDict)(NSDictionary  *dict);


typedef void(^pushArr)(NSMutableArray *array);
typedef void(^Error)(NSString *error);
@interface HYHttpTools : NSObject


+(instancetype)shareHttpTools;
//-(void)HY_setHttpToPhoto:(NSString *)url params:(NSDictionary *)params imageData:(NSData *)imageData passValue:(pushDict)value  error:(Error)Error;

#pragma  mark 封装处理数据 返回字典
/**
 *  封装处理数据 返回字典
 */
-(void)HY_setHttpToJsonArray:(NSString *)url params:(id)params  type:(ASKTYPE)type isJson:(BOOL)isJson passValue:(pushArr)value error:(Error)Error;

@end
