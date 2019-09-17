//
//  GCJBaseTableCell.h
//  58GuCheJia
//
//  Created by 吴丹 on 2018/3/26.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Corner.h"

@class GCJBaseTableCell;
@protocol GCJBaseTableCellDelegate<NSObject>

//cell中的子view被点击事件
//data:对应的model
- (void)tableViewCell:(GCJBaseTableCell *)cell subViewDidSelectAtIndexPath:(NSIndexPath *)indexPath data:(id)data;
//跳转
- (void)handleWithPath:(NSString *)path param:(NSDictionary *)param;
- (void)tableViewCell:(GCJBaseTableCell *)cell reloadViewAtIndexPath:(NSIndexPath*)indexPath;
@end

@interface GCJBaseTableCell : UITableViewCell
@property (nonatomic, weak) id<GCJBaseTableCellDelegate> delegate;
@property (nonatomic, assign) float bottomLineHeight;  //底部线条等宽度，默认0
@property (nonatomic, assign) float bottomLineLeft;  //bottom距左边的距离 默认15
@property (nonatomic, assign) float bottomLineWidth;  //bottom的宽度 默认到cell的最右边
@property (nonatomic, assign) UIRectCorner rectCorner;  //切圆角的方向
@property (nonatomic, assign) float cornerRadius;  //切圆角的半径 默认10
@property (nonatomic, strong) UIColor *bottomLineColor;  //底部线条颜色

//给子类重写，主要是用来处理传过来的数据，updateSubView之类的
- (void)prepareViewWithData:(id)data indexPath:(NSIndexPath *)indexPath;
//获取cell的高度
+ (float)computeHeightWithCellData:(id)data;
- (void)createSubViews;  //初始化子控件
@end
