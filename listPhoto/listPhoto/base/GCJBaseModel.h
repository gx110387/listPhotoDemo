//
//  GCJHomeModel.h
//  58GuCheJia
//
//  Created by 吴丹 on 2018/3/27.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GCJBaseModel : NSObject
@property (nonatomic, strong) NSDictionary *data;
 
//action的字典形式，格式：
/*
 {
 "action":"jumppage",
 "pagetype":"界面标识",
 "param":{} //参数
 }
 */

@property (nonatomic, assign, getter=isLastItem) BOOL lastItem;
@property (nonatomic, assign, getter=isFirstItem) BOOL firstItem;

- (instancetype)initWithData:(id)data;

@end
