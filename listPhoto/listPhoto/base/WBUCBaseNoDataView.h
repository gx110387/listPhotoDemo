//
//  WBUCBaseNoDataView.h
//  58GuCheJiaCommons
//
//  Created by mazhichao on 2018/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
// 定义常量key，不希望外部修改
UIKIT_EXTERN NSString *const EmptyTitleKey; // 请求成功，数据为空
UIKIT_EXTERN NSString *const ErrorTitleKey; // 请求失败
UIKIT_EXTERN NSString *const EmptySubTitleKey; // 请求成功，数据为空
UIKIT_EXTERN NSString *const ErrorSubTitleKey; // 请求失败
UIKIT_EXTERN NSString *const EmptyBtnKey; // 请求成功，数据为空
UIKIT_EXTERN NSString *const ErrorBtnKey; // 请求失败
UIKIT_EXTERN NSString *const EmptyImageKey; // 请求成功，数据为空
UIKIT_EXTERN NSString *const ErrorImageKey; // 请求失败

@interface WBUCBaseNoDataView : UIView

/**
 点击界面相应事件
 */
@property (nonatomic, copy) void(^requstAgain)(void);
@property (nonatomic, assign) BOOL hideBtn; // 默认为NO

/**
 初始化

 @param superView 父类视图，视图为空返回self 大小zero
 @param remindDic 无数据提示字典，key按照给定的来
 @return self
 */
-(instancetype)initWithSuperView:(UIView *)superView remindDic:(NSDictionary *)remindDic hideBtn:(BOOL) hideBtn;

/**
 决定显示错误信息还是无数据信息

 @param iserror 是否成功
 */
-(void) noDataIsError:(BOOL) iserror;

/**
 允许点击整个界面相应回调方法
 */
- (void) setViewCanClick;

- (void)showTips:(NSString *)title
        btnTitle:(NSString *)btnTitle
        callBack:(void(^)(void))callBack;

- (void)showTips:(NSString *)title
         imgName:(NSString *)imgName
        btnTitle:(NSString *)btnTitle
        callBack:(void(^)(void))callBack;

- (void)showTips:(NSString *)title;
- (void)showTips:(NSString *)title superView:(UIView *)superView;
@end

NS_ASSUME_NONNULL_END
