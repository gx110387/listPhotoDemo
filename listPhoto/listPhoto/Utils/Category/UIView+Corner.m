//
//  UIView+Corner.m
//  TestPods
//
//  Created by 吴丹 on 2018/3/26.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)
- (void)roundingCorners:(UIRectCorner)corners radius:(float)radius{
    self.layer.mask = nil;
//    NSLog(@"%@",NSStringFromClass(self.class));
    if(corners && corners != kRectCornerNONE){
        CGRect bounds= CGRectZero;
        CGFloat offsetPoint = 1;
//        NSLog(@"+++++");
        if (corners == (UIRectCornerBottomLeft | UIRectCornerBottomRight)) {
            bounds = CGRectMake(0, -offsetPoint, self.bounds.size.width, self.bounds.size.height+offsetPoint);
        } else if (corners == (UIRectCornerTopLeft | UIRectCornerTopRight)) {
            bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height+offsetPoint);
        } else {
            bounds = self.bounds;
        }
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }else{
//        self.layer.mask = nil;
//        NSLog(@"-----");
    }
    
}
@end
