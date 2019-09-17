//
//  UIColor+Hex.h
//  TestPods
//
//  Created by 吴丹 on 2018/1/18.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)opacity;
+ (UIColor *)colorWithHexString: (NSString *)color;
@end
