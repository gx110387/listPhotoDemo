//
//  GCJBaseViewController.h
//  58GuCheJia
//
//  Created by 吴丹 on 2018/3/24.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBUCBaseNoDataView.h"

@interface GCJBaseViewController : UIViewController
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) WBUCBaseNoDataView *noDataView;
@property (nonatomic, assign) BOOL ignoreRightScroll;  //忽略右滑效果
- (void)backAction:(id)sender;
- (void)addBackButton;
- (void)addBackButtonOnRootWithTarget:(id)target action:(SEL)action;
- (void)addBackButtonWithImage:(NSString *)image;

- (BOOL)judgeCurrentVCisPushenter;//判断是否是push进来的

- (void)setNavBarColor:(UIColor *)barColor barTintColor:(UIColor *)barTintColor;

//添加路由调用方法的通用通知，调用该方法之后，子类只需要实现path中的方法就可以
- (void)addHandleDispatchNotificationName:(NSString *)name;

/**
 界面刷新数据，包含无数据、请求失败提示
 
 @param view 需要刷新的界面
 @param list 界面数据
 @param remindDic 提示语字典，使用默认提示语可以传空
 @param success 界面数据为空的前提下，界面请求是成功与否
 @param request 无数据界面点击回调
 */
- (void)reloadWithView:(UIView *)view
              infoList:(id)list
             remindDic:(NSDictionary *)remindDic
               success:(BOOL)success
          requestAgain:(void(^)(void))request;
/**
 判断是否是一级界面
 */
-(BOOL)isFirstLevelView;
@end
