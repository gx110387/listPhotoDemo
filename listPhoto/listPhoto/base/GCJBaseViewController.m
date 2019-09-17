//
//  GCJBaseViewController.m
//  58GuCheJia
//
//  Created by 吴丹 on 2018/3/24.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import "GCJBaseViewController.h"
//#import "GCJNavigationController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>
#import "UINavigationController+Addition.h"
#import "UIColor+Hex.h"


@interface GCJBaseViewController () <UIGestureRecognizerDelegate>
@end

@implementation GCJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController hiddenBottomLine];
    self.fd_interactivePopDisabled = self.ignoreRightScroll;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f8fa"];
    [self addBackButton];
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _bgImageView.image = [UIImage imageNamed:@"gcj_bg"];
        [self.view addSubview:_bgImageView];
        [self.view sendSubviewToBack:_bgImageView];
    }
    return _bgImageView;
}

- (void)addBackButton
{
    UINavigationController *NavVC = self.navigationController;
    if (NavVC && NavVC.childViewControllers.count > 0) {
        UIViewController *viewController = [NavVC getChildControllerWithIndex:0];
        if (self != viewController) {
            UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [backBtn setImage:[UIImage imageNamed:@"ic_common_back"] forState:UIControlStateNormal];
            [backBtn setImage:[UIImage imageNamed:@"ic_common_back"] forState:UIControlStateHighlighted];
            [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
            [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            [backBtn setFrame:CGRectMake(0, 0, 40, 50)];
            self.fd_prefersNavigationBarHidden = YES;
            UIBarButtonItem * backBar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
            self.navigationItem.leftBarButtonItem = backBar;
       }
    }
}

- (void)addBackButtonWithImage:(NSString *)image {
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -17, 0, 0)];
    [backBtn setFrame:CGRectMake(0, 0, 40, 50)];
    self.fd_prefersNavigationBarHidden = YES;
    
    UIBarButtonItem * backBar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBar;
}

- (void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBackButtonOnRootWithTarget:(id)target action:(SEL)action
{
    [self addBackButtonOnRootWithTarget:target action:action btnText:NSLocalizedString(@"back", nil)];
}

- (void)addBackButtonOnRootWithTarget:(id)target action:(SEL)action btnText:(NSString *)btnText
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"ic_common_back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"ic_common_back"] forState:UIControlStateHighlighted];
    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 10)];
    [backBtn setFrame:CGRectMake(0, 0, 40, 50)];
    self.fd_prefersNavigationBarHidden = YES;
    
    UIBarButtonItem * backBar = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBar;
}

//判断当前视图进入的方式，是push还是present
- (BOOL)judgeCurrentVCisPushenter{
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            return YES;
        }
    }
    else{
        //present方式
        return NO;
    }
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)dealloc
{
    NSLog(@"dealloc --------- %@", NSStringFromClass([self class]));
}

- (void)setNavBarColor:(UIColor *)barColor barTintColor:(UIColor *)barTintColor{
    self.navigationController.navigationBar.barTintColor = barTintColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:barColor}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


//路由方法
- (void)addHandleDispatchNotificationName:(NSString *)name{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(common_dispatchAction:)
                                                 name:name
                                               object:nil];
}

//路由调用方法统一转发到子类中去实现
#pragma mark --
#pragma mark -- dispatch action
- (void)common_dispatchAction:(NSNotification *)notifation{
    NSString *path = notifation.object;
    if (!path || path.length ==0) {
        return;
    }
    id param = notifation.userInfo;
    NSArray *conpent = [path componentsSeparatedByString:@"/"];
    if (conpent.lastObject) {
        //这个看咱们定义的协议类型来获取方法名和参数
        NSString *func = [conpent.lastObject stringByAppendingString:@":"];
        SEL selector = NSSelectorFromString(func);
        if (selector && [self respondsToSelector:selector]) {
            [self performSelector:selector withObject:param];
        }
    }
}
- (void)reloadWithView:(UIView *)view
              infoList:(id)list
             remindDic:(NSDictionary *)remindDic
               success:(BOOL)success
          requestAgain:(void(^)(void))request
{
    NSMutableDictionary *tempRemindDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                         EmptyImageKey:@"GCJ_noDataImage",
                                                                                         ErrorImageKey:@"GCJ_noDataImage"
                                                                                         }];
    if (remindDic) {
        [tempRemindDic addEntriesFromDictionary:remindDic];
    }
    if (!_noDataView) {
        _noDataView = [[WBUCBaseNoDataView alloc]initWithSuperView:view remindDic:tempRemindDic hideBtn: ([self isFirstLevelView] && success)];
    }
    
    // 没有数据的情况
    if (list == nil
        || ([list isKindOfClass:[NSArray class]] && [list count] == 0)
        || ([list isKindOfClass:[NSDictionary class]] && [list allKeys].count == 0)
        ){
        if (!_noDataView.requstAgain) {
            _noDataView.requstAgain = request;
        }
        _noDataView.hidden = NO;
        _noDataView.hideBtn = ([self isFirstLevelView] && success);
        [_noDataView noDataIsError: (success == false)];
        
    }else{
        _noDataView.hidden = YES;
    }
}
/**
 判断是否是一级界面
 */
-(BOOL)isFirstLevelView{
    
    return self.navigationController.viewControllers.count == 1;
}

- (WBUCBaseNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[WBUCBaseNoDataView alloc] init];
        [self.view sendSubviewToBack:_noDataView];
    }
    return _noDataView;
}

@end
