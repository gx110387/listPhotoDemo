//
//  ZSHomeModel.m
//  listPhoto
//
//  Created by     gaoxing on 2019/9/16.
//  Copyright © 2019 gaoxing. All rights reserved.
//

#import "ZSHomeDataModel.h"

@implementation ZSUrlsItemModel


@end

@implementation ZSHomeDataModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [self init]) {
        [self parseObjectParam:dict];
        
        ZSUrlsItemModel *model = [[ZSUrlsItemModel alloc]initWithDict:dict[@"urls"]];
        _urls = model;
        _content = [dict[@"description"] isEqual: [NSNull null]]?@"":[dict[@"description"] description];
       
    }
    return self;
}

@end
