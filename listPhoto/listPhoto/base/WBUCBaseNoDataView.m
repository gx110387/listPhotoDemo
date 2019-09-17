//
//  WBUCBaseNoDataView.m
//  58GuCheJiaCommons
//
//  Created by mazhichao on 2018/10/11.
//

#import "WBUCBaseNoDataView.h"
#import "UIColor+Hex.h"
#import "UIView+Corner.h"
#import "Masonry.h"

NSString *const EmptyTitleKey = @"EmptyTitleKey";
NSString *const ErrorTitleKey = @"ErrorTitleKey";
NSString *const EmptySubTitleKey = @"EmptySubTitleKey";
NSString *const ErrorSubTitleKey = @"ErrorSubTitleKey";
NSString *const EmptyBtnKey = @"EmptyBtnKey";
NSString *const ErrorBtnKey = @"ErrorBtnKey";
NSString *const EmptyImageKey = @"EmptyImageKey"; // 请求成功，数据为空
NSString *const ErrorImageKey = @"ErrorImageKey"; // 请求失败

@interface WBUCBaseNoDataView()
@property (nonatomic, strong) UIImageView *emptyImage;
@property (nonatomic, strong) UILabel *emptyLable;
@property (nonatomic, strong) UILabel *emptySubLable;
@property (nonatomic, strong) UIButton *emptyBtn;

@property (nonatomic, strong) NSMutableDictionary *emptyDic;// 包含三个key，errorKey:请求失败、无网络情况 emptyKey: 请求成功但是没有数据，btnText: 请求成功但是没有数据情况下的文字

@end

@implementation WBUCBaseNoDataView
-(instancetype)initWithSuperView:(UIView *)superView remindDic:(NSDictionary *)remindDic hideBtn:(BOOL)hideBtn{
    if (self = [super init]) {
        if (superView == nil) {
            return self;
        }
        [self setRemindeDic:remindDic];
        _hideBtn = hideBtn;
        if ([superView isKindOfClass:[UITableView class]]) {
            UITableView *view = (UITableView *)superView;
            view.backgroundView = self;
        }else if([superView isMemberOfClass:[UIScrollView class]]){
            
        }else{
            [superView addSubview:self];
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.left.right.mas_equalTo(superView);
            }];
        }
        [self setSubView];
        [self registerAction];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setSubView];
        [self registerAction];
    }
    return self;
}

/**
 添加子控件
 */
- (void)setSubView{
    _emptyImage = [[UIImageView alloc]init];
    
    _emptyLable = [[UILabel alloc]init];
    _emptyLable.font = [UIFont systemFontOfSize:18];
    _emptyLable.textColor = [UIColor colorWithHex:0x333333];
    _emptyLable.textAlignment = NSTextAlignmentCenter;
    _emptyLable.numberOfLines = 0;
    
    _emptySubLable = [[UILabel alloc]init];
    _emptySubLable.font = [UIFont systemFontOfSize:14];
    _emptySubLable.textColor = [UIColor colorWithHex:0x999999];
    _emptySubLable.textAlignment = NSTextAlignmentCenter;
    _emptySubLable.numberOfLines = 0;
    
    _emptyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_emptyBtn setBackgroundColor:[UIColor colorWithHex:0x3777D6 ]];
    _emptyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_emptyBtn setTitleColor:[UIColor colorWithHex:0xffffff] forState:UIControlStateNormal];
//    _emptyBtn.layer.borderColor = [UIColor colorWithHex:0xfda888].CGColor;
    _emptyBtn.layer.borderWidth = 1;
    _emptyBtn.layer.cornerRadius = 3;
    _emptyBtn.layer.masksToBounds = YES;
    [_emptyBtn setTitle:@"请求失败，稍后重试" forState:UIControlStateNormal];
    
    [self addSubview:_emptyImage];
    [self addSubview:_emptyLable];
    [self addSubview:_emptySubLable];
    [self addSubview:_emptyBtn];
    
    [_emptyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(-25);
        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.mas_left).offset(20);
    }];
    [_emptySubLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emptyLable.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        make.left.equalTo(self.mas_left).offset(20);
    }];
    [_emptyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.emptyLable);
        make.bottom.equalTo(self.emptyLable.mas_top).offset(-20);
    }];
    
    [_emptyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.emptyLable);
        make.top.equalTo(self.emptySubLable.mas_bottom).offset(20);
        make.height.offset(33);
        make.width.greaterThanOrEqualTo(@(150)); // 设置最小宽度为100
    }];
}


/**
 注册点击事件
 */
- (void)registerAction{
    if (_emptyBtn) {
        [_emptyBtn addTarget:self action:@selector(touchRequestAngain) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)setViewCanClick{
    // 在某种情况下可能需要点击整个View来触发点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchRequestAngain)];
    [self addGestureRecognizer:tap];
}
- (void)touchRequestAngain{
    self.requstAgain();
}

/**
 设置界面内容
 @param iserror 是否是因为请求错误导致
 */
-(void) noDataIsError:(BOOL) iserror{
    _emptyBtn.hidden = _hideBtn;
    if (iserror) {
        _emptyLable.text = _emptyDic[ErrorTitleKey];
        [_emptyBtn setTitle:_emptyDic[ErrorBtnKey] forState:UIControlStateNormal];
        _emptyBtn.hidden = !(_emptyDic[ErrorBtnKey] && [_emptyDic[ErrorBtnKey] length] > 0);
        _emptyImage.image = [self imageWithNamed:_emptyDic[ErrorImageKey]];
    }else{
        _emptyLable.text = _emptyDic[EmptyTitleKey];
        _emptySubLable.text = _emptyDic[EmptySubTitleKey];
        [_emptyBtn setTitle:_emptyDic[EmptyBtnKey] forState:UIControlStateNormal];
        _emptyBtn.hidden = !(_emptyDic[EmptyBtnKey] && [_emptyDic[EmptyBtnKey] length] > 0);
        _emptyImage.image = [self imageWithNamed:_emptyDic[EmptyImageKey]];
    }
}
-(UIImage *)imageWithNamed:(NSString *)imageNamed{
    if (imageNamed) {
        return [UIImage imageNamed:imageNamed];
    }
    return nil;
}
/**
 设置界面类型
 */
-(void)setRemindeDic:(NSDictionary *)dic{
    if (!_emptyDic) {
        // 默认字典
        _emptyDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                    EmptyTitleKey : @"暂无数据",
                                                                    ErrorTitleKey : @"",
                                                                    EmptySubTitleKey : @"我们正在快马加鞭补充",
                                                                    ErrorSubTitleKey : @"网络连接失败",
                                                                    EmptyBtnKey : @"返回",
                                                                    ErrorBtnKey : @"重新加载",
                                                                    EmptyImageKey:@"GCJ_noDataImage",
                                                                    ErrorImageKey:@"GCJ_noDataImage"
                                                                    }];
    }
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        [_emptyDic addEntriesFromDictionary:dic];
    }
}

- (void)showTips:(NSString *)title
{
    [self showTips:title btnTitle:@"" callBack:nil];
}

- (void)showTips:(NSString *)title superView:(UIView *)superView
{
    [self showTips:title btnTitle:@"" callBack:nil];
    if (![self.superview isEqual:superView]) {
        [superView addSubview:self];
        [superView sendSubviewToBack:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(superView);
        }];
    }
}

- (void)showTips:(NSString *)title btnTitle:(NSString *)btnTitle callBack:(void (^)(void))callBack
{
    [self showTips:title imgName:@"appraiserList_noDataImage" btnTitle:btnTitle callBack:callBack];
}

- (void)showTips:(NSString *)title imgName:(NSString *)imgName btnTitle:(NSString *)btnTitle callBack:(void (^)(void))callBack{
    self.hidden = NO;
    self.emptyLable.text = title;
    [self.emptyBtn setTitle:btnTitle forState:UIControlStateNormal];
    self.emptyBtn.hidden = btnTitle.length == 0;  //隐藏btn
    self.emptyImage.image = [self imageWithNamed:imgName];
    self.requstAgain = callBack;
}

@end
