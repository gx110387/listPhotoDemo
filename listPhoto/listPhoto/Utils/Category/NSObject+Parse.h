//
//  NSObject+Parse.h
//  UsedCar_SP0
//
//  Created by 吴丹 on 2018/2/1.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import <Foundation/Foundation.h>
//解析
@interface NSObject (Parse)
/*
 * @DO      将dict中的数据解析给object中的属性赋值
 * @param   数据
 * @return  对应的实例
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

- (void)parseObjectParam:(NSDictionary *)dict;
@end
