//
//  UCNavBar.h
//  UsedCar_SP0
//
//  Created by 吴丹 on 2018/3/9.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,UCBarButtonItemType){
    UCBarButtonItemType_None = 0,
    UCBarButtonItemType_Message = 1,
    UCBarButtonItemType_guzhiReport = 2
    
};
NS_ASSUME_NONNULL_BEGIN
@interface UCBarButtonItem : UIView
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIFont *titleFont;  //默认15
@property (nonatomic, assign) UCBarButtonItemType itemType;
- (instancetype)initWithCustomView:(UIView *)customView;
- (instancetype)initWithTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action;
- (instancetype)initWithImage:(UIImage *)image target:(nullable id)target action:(nullable SEL)action;
- (instancetype)initWithImageName:(NSString *)imageName target:(nullable id)target action:(nullable SEL)action;
@end

@interface UCNavBar : UIView
@property (nonatomic, copy) NSString *title;  //标题
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) BOOL showBottomLine;
@property (nonatomic, strong) UCBarButtonItem *leftBarItem;  //左边按钮
@property (nonatomic, strong) UCBarButtonItem *rightBarItem;  //右边按钮
@property (nonatomic, strong) NSArray <UCBarButtonItem *> *leftBarItems;
@property (nonatomic, strong) NSArray <UCBarButtonItem *> *rightBarItems;
@property (nonatomic, strong) UIColor *itemTintColor;  //item的颜色，如title的颜色，leftBarItem和rightBarItem的颜色
@property (nonatomic, strong) UIColor *barTintColor;   //bar的颜色
@property (nonatomic, assign) CGFloat barAlpha;  //bar的透明度
@property (nonatomic, assign) CGFloat titleAlpha;  //title的透明度

@property (nonatomic, strong, readonly)UIView *unreaderMsgCountView; //只读的消息

@property (nonatomic, assign) BOOL isShowIm; //货车


@end
NS_ASSUME_NONNULL_END
