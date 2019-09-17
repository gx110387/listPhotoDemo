//
//  MBProgressHUD+Add.h
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)
+ (void)showError:(NSString *)error detailsText:(NSString *)details toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success detailsText:(NSString *)details toView:(UIView *)view;


+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

+ (void)showTipMessage:(NSString *)tipMessage;
+ (void)showTipMessage:(NSString *)tipMessage showTime:(CGFloat)showTime;
+ (void)showTipMessage:(NSString *)tipMessage showTime:(CGFloat)showTime toView:(UIView *)view isTouch:(BOOL)isTouch;
//默认在appcation的window上显示
+ (void)showError:(NSString *)error detailsText:(NSString *)details;
+ (void)showSuccess:(NSString *)success detailsText:(NSString *)details;
+ (MBProgressHUD *)showMessag:(NSString *)message;

/*
 * @DO      toast
 * @param   state 提示类型：error ，warn，prompt
 */
+ (void)showTipMessageWithState:(NSString *)state text:(NSString *)text;

@end
