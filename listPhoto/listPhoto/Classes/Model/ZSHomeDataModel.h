//
//  ZSHomeModel.h
//  listPhoto
//
//  Created by     gaoxing on 2019/9/16.
//  Copyright © 2019 gaoxing. All rights reserved.
//

#import "GCJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface ZSUrlsItemModel : GCJBaseModel
@property (nonatomic, copy) NSString *raw;
@property (nonatomic, copy) NSString *full;
@property (nonatomic, copy) NSString *regular;
@property (nonatomic, copy) NSString *small;
@property (nonatomic, copy) NSString *thumb;
@end

@interface ZSHomeDataModel : GCJBaseModel
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *color;
/// 喜欢
@property (nonatomic, copy) NSString *likes;
/// 是否喜欢
@property (nonatomic, assign) BOOL liked_by_user;
/// 标题
@property (nonatomic, copy) NSString *content;
/// 用户信息
@property (nonatomic, strong) NSDictionary *user;
/// 我的收藏
@property (nonatomic, strong) NSArray *current_user_collections;
/// 图片清晰度
@property (nonatomic, strong) ZSUrlsItemModel *urls;
// 链接
@property (nonatomic, strong) NSDictionary *links;
@end

NS_ASSUME_NONNULL_END
