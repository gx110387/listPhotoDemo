//
//  UINavigationController+Addition.m
//  58GuCheJia
//
//  Created by 吴丹 on 2018/4/20.
//  Copyright © 2018年 58. All rights reserved.
//

#import "UINavigationController+Addition.h"

@implementation UINavigationController (Addition)
- (UIViewController *)getChildControllerWithIndex:(NSInteger)index{
    if (self.viewControllers.count == 0) {
        return nil;
    }
    UIViewController *viewController = self.viewControllers[0];
    if ([viewController isKindOfClass:[RTContainerController class]]) {
        return [(RTContainerController *)viewController contentViewController];
    }else{
        return viewController;
    }
}

- (UIImageView *)findBarBottomLineImageView{
    return [self _findBarBottomLineImageView:self.navigationBar];
}

// 找到横线视图
- (UIImageView *)_findBarBottomLineImageView:(UIView *)view {
    if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subView in view.subviews) {
        UIImageView *imageView = [self _findBarBottomLineImageView:subView];// 递归
        if (imageView) {
            return  imageView;
        }
    }
    return nil;
}

- (void)hiddenBottomLine
{
    UIImageView *imageView = [self findBarBottomLineImageView];
    imageView.hidden = YES;
}

@end
