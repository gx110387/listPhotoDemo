//
//  GCJHomeModel.m
//  58GuCheJia
//
//  Created by 吴丹 on 2018/3/27.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import "GCJBaseModel.h"
#import "NSObject+Parse.h"

@implementation GCJBaseModel
- (instancetype)initWithData:(id)data
{
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

- (void)setData:(NSDictionary *)data{
    _data = data;
    [self parseObjectParam:data];
}

@end
