//
//  UIView+Helper.h
//  UsedCar_SP0
//
//  Created by 吴丹 on 2018/1/24.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KIT_SCREEN_WIDTH                   [UIScreen mainScreen].bounds.size.width
#define KIT_SCREEN_HEIGHT                  [UIScreen mainScreen].bounds.size.height

#define KIT_NavBarHeight                  (44)
#define KIT_TabBarHeight                  (49)

#define KIT_isiPhoneX                      isIPhoneXSeries() //(([[UIScreen mainScreen] bounds].size.height)==812.f ? 1 : 0)

#define KIT_StatusBarHeight               ((KIT_isiPhoneX) ? 44.f : 20.f)
#define KIT_iPhoneXStatusBarFitHeight     ((KIT_isiPhoneX) ? 24.f : 0.f)
#define KIT_iPhoneXBottomUnSafeAreaHeight ((KIT_isiPhoneX) ? 34.f : 0.f)

#define KIT_NavBarBottom                   ((KIT_NavBarHeight)+(KIT_StatusBarHeight))

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (Helper)
@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;

- (void)moveBy:(CGPoint) delta;
- (void)scaleBy:(CGFloat) scaleFactor;
- (void)fitInSize:(CGSize) aSize;
- (void)drawBottomShadowOffset:(float)offset
                       opacity:(float)opacity;
@end
