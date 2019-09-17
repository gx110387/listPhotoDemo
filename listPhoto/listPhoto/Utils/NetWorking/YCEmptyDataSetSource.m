//
//  YCEmptyDataSetSource.m
//  checkAPP
//
//  Created by qi chao on 2017/3/6.
//  Copyright © 2017年 qi chao. All rights reserved.
//

#import "YCEmptyDataSetSource.h"

@implementation YCEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"pic_empty"];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -0;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}


@end
