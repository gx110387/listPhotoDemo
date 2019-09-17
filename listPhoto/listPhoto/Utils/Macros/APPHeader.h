//
//  APPHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里存放普通的app宏定义和声明等信息.

#ifndef Project_APPHeader_h
#define Project_APPHeader_h
//============
// block self
#define WEAKSELF __weak typeof(self) weakself = self;
#define STRONGSELF typeof(weakself) __strong strongSelf = weakself;

#define SCREEN_WIDTH                   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT                  [UIScreen mainScreen].bounds.size.height

#define kNavBarHeight                  (44)
#define kTabBarHeight                  (49)

#define isiOS11Above                   ([UIDevice currentDevice].systemVersion.floatValue >= 11.0 ? 1 : 0)
#define isiPhoneX                      isIPhoneXSeries() //(([[UIScreen mainScreen] bounds].size.height)==812.f ? 1 : 0)

static inline BOOL isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}
#define kStatusBarHeight               ((isiPhoneX) ? 44.f : 20.f)
#define kiPhoneXStatusBarFitHeight     ((isiPhoneX) ? 24.f : 0.f)
#define kiPhoneXBottomUnSafeAreaHeight ((isiPhoneX) ? 34.f : 0.f)

#define kNaviAndStatusBarHeight         (kStatusBarHeight+kNavBarHeight)


#define kNavBarBottom                   ((kNavBarHeight)+(kStatusBarHeight))

/
#endif
