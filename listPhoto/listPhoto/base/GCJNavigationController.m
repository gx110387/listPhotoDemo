//
//  GCJNavigationController.m
//  58GuCheJia
//
//  Created by 吴丹 on 2018/3/24.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import "GCJNavigationController.h"
#import "GCJBaseViewController.h"


@interface GCJNavigationController ()
@property (nonatomic, assign) BOOL shouldIgnorePushingViewControllers;
@end

@implementation GCJNavigationController

+ (void)initialize{
    //因为不是所有界面的barTintColor都一样，所以最好不要直接写
    [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    [UINavigationBar appearance].translucent = false;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;  //隐藏底部tabbar
    }
    [super pushViewController:viewController animated:animated];
}


@end
