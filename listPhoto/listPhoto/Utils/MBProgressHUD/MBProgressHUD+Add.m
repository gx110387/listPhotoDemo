//
//  MBProgressHUD+Add.m
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+Add.h"

@implementation MBProgressHUD (Add)

#pragma mark 显示信息
+ (void)show:(NSString *)text detailsText:(NSString *)details icon:(NSString *)icon view:(UIView *)view showTime:(CGFloat)showTime isTouch:(BOOL)isTouch
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = !isTouch;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    if (details) {
        hud.detailsLabel.text = details;
        if (text.length==0) {
            hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15];
        }
    }
    // 设置图片
    if (icon) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    }
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.contentColor = [UIColor whiteColor]; //文字颜色
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.6]; //hud的背景颜色
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;//去掉毛玻璃效果
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

    if (showTime) {
        [hud hideAnimated:YES afterDelay:showTime];
    }else{
        // n秒之后再消失
        [hud hideAnimated:YES afterDelay:1.5];
    }
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error detailsText:(NSString *)details toView:(UIView *)view {
    [self show:error detailsText:details icon:@"error.png" view:view showTime:0.0 isTouch:NO];
}

+ (void)showSuccess:(NSString *)success detailsText:(NSString *)details toView:(UIView *)view
{
    [self show:success detailsText:details icon:@"success.png" view:view showTime:0.0 isTouch:NO];
}

+ (void)showTipMessage:(NSString *)tipMessage
{
    tipMessage = [NSString stringWithFormat:@"%@",tipMessage];
    [self show:nil detailsText:tipMessage icon:nil view:[UIApplication sharedApplication].keyWindow showTime:0.0 isTouch:NO];
}
+ (void)showTipMessage:(NSString *)tipMessage showTime:(CGFloat)showTime{
    tipMessage = [NSString stringWithFormat:@"%@",tipMessage];
    [self show:nil detailsText:tipMessage icon:nil view:[UIApplication sharedApplication].keyWindow showTime:showTime isTouch:NO];
}
+ (void)showTipMessage:(NSString *)tipMessage showTime:(CGFloat)showTime toView:(UIView *)view isTouch:(BOOL)isTouch{
    tipMessage = [NSString stringWithFormat:@"%@",tipMessage];
    [self show:nil detailsText:tipMessage icon:nil view:view showTime:showTime isTouch:isTouch];
}
#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (MBProgressHUD *)showMessag:(NSString *)message
{
    return [self showMessag:message toView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showSuccess:(NSString *)success detailsText:(NSString *)details
{
    [self showSuccess:success detailsText:details toView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showError:(NSString *)error detailsText:(NSString *)details
{
    [self showError:error detailsText:details toView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showTipMessageWithState:(NSString *)state text:(NSString *)text
{
    if ([state isEqualToString:@"error"]) {
        [MBProgressHUD showError:nil detailsText:text];
        return;
    }
    if ([state isEqualToString:@"warn"]) {
        [MBProgressHUD showTipMessage:text];
        return;
    }
    if ([state isEqualToString:@"prompt"]) {
        [MBProgressHUD showTipMessage:text];
        return;
    }
    [MBProgressHUD showTipMessage:text];
}

@end
