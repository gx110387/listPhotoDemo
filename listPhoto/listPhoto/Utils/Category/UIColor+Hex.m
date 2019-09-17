//
//  UIColor+Hex.m
//  TestPods
//
//  Created by 吴丹 on 2018/1/18.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)
+ (UIColor *)colorWithHex:(long)hexColor{
    CGFloat red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0;
    CGFloat green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0;
    CGFloat blue = ((CGFloat)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)opacity
{
    CGFloat red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0;
    CGFloat green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0;
    CGFloat blue = ((CGFloat)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (UIColor *) colorWithHexString: (NSString *)color{
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end
