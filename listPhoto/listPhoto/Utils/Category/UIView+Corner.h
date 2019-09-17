//
//  UIView+Corner.h
//  TestPods
//
//  Created by 吴丹 on 2018/3/26.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kRectCornerNONE  9999   //没有圆角

@interface UIView (Corner)
- (void)roundingCorners:(UIRectCorner)corners radius:(float)radius;
@end
