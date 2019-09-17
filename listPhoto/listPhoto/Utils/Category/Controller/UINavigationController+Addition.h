//
//  UINavigationController+Addition.h
//  58GuCheJia
//
//  Created by 吴丹 on 2018/4/20.
//  Copyright © 2018年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RTRootNavigationController.h>

@interface UINavigationController (Addition)
- (UIViewController *)getChildControllerWithIndex:(NSInteger)index;
//找到底部的line
- (UIImageView *)findBarBottomLineImageView;
- (void)hiddenBottomLine;
@end
