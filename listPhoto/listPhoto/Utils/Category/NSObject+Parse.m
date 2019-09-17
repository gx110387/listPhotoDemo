//
//  NSObject+Parse.m
//  UsedCar_SP0
//
//  Created by 吴丹 on 2018/2/1.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import "NSObject+Parse.h"
#import <objc/runtime.h>

@implementation NSObject (Parse)
- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [self init]) {
        //(1)获取类的属性及属性对应的类型
//        NSMutableArray * keys = [NSMutableArray array];
//        NSMutableArray * attributes = [NSMutableArray array];
        /*
         * 例子
         * name = value3 attribute = T@"NSString",C,N,V_value3
         * name = value4 attribute = T^i,N,V_value4
         */
        [self parseObjectParam:dict];
        
        //(2)根据类型给属性赋值
//        for (NSString * key in keys) {
//            if ([dict valueForKey:key] == nil ||
//                ![self respondsToSelector:@selector(key)]) continue;
//            [self setValue:[dict valueForKey:key] forKey:key];
//        }
    }
    return self;
}

- (void)parseObjectParam:(NSDictionary *)dict{
    if(![dict isKindOfClass:[NSDictionary class]]){
        return;
    }
    unsigned int outCount;
    objc_property_t * properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //通过property_getName函数获得属性的名字
        NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        //            [keys addObject:propertyName];

        id value = dict[propertyName];
        if (value) {
            [self setValue:value forKey:propertyName];
        }

        //通过property_getAttributes函数可以获得属性的名字和@encode编码
        //            NSString * propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        //            [attributes addObject:propertyAttribute];
    }
    //立即释放properties指向的内存
    free(properties);
}

@end
