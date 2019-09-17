//
//  UCNavBar.m
//  UsedCar_SP0
//
//  Created by 吴丹 on 2018/3/9.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import "UCNavBar.h"
//#import "Defined.h"
#import "UIView+Helper.h"
//#import "UIImage+Helper.h"
//#import <NSString+Addtion.h>
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import <Masonry.h>

#define kPadding  10
@interface UCBarButtonItem()
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL action;
@end

@implementation UCBarButtonItem
- (UIFont *)titleFont
{
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:16];
    }
    return _titleFont;
}
- (instancetype)initWithCustomView:(UIView *)customView
{
    self = [super init];
    if (self) {
        self.customView = customView;
        [self addSubview:customView];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image target:(nullable id)target action:(nullable SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateHighlighted];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 40, 44)];
    self = [self initWithCustomView:button];
    self.frame = CGRectMake(15, KIT_StatusBarHeight, 40, KIT_NavBarHeight);
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName target:(nullable id)target action:(nullable SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([imageName hasPrefix:@"http"]) {
        NSURL *url = [NSURL URLWithString:imageName];
        [button sd_setImageWithURL:url forState:UIControlStateNormal];
        [button sd_setImageWithURL:url forState:UIControlStateHighlighted];
    }else{
        UIImage *image = [UIImage imageNamed:imageName];
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
    }
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 40, 50)];
    self = [self initWithCustomView:button];
    self.frame = CGRectMake(0, KIT_StatusBarHeight, 40, KIT_NavBarHeight);
    return self;
}

- (instancetype)initWithTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action
{
    //通过title计算button的大小
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = self.titleFont;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self = [self initWithCustomView:button];
    [self updateFrameWithTitle:title];
    return self;
}

- (CGSize)sizeForString:(NSString *)string havingWidth:(CGFloat)width andFont:(UIFont *)font {
    CGRect frame = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil] context:nil];
    return frame.size;//CGSizeMake(frame.size.width, frame.size.height + 1);
}

//更新item的frame
- (void)updateFrameWithTitle:(NSString *)title{
    //通过title计算button的大小
    CGSize titleSize = [self sizeForString:title havingWidth:KIT_SCREEN_WIDTH andFont:self.titleFont];
    self.frame = CGRectMake(kPadding, KIT_StatusBarHeight, titleSize.width, KIT_NavBarHeight);
    self.customView.frame = self.bounds;
}

- (void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
    if (!self.customView || ![self.customView isKindOfClass:[UIButton class]]) {
        return;
    }
    UIButton *btn = (UIButton *)self.customView;
    if (btn.titleLabel.text.length != 0) {
        [btn setTitleColor:tintColor forState:UIControlStateNormal];
    }
    //改变btn的图片颜色
    if (btn.currentBackgroundImage) {
//        UIImage *image = [btn.currentBackgroundImage imageWithColor:tintColor];
//        [btn setBackgroundImage:image forState:UIControlStateNormal];
    }
}

@end

@interface UCNavBar()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) NSArray *constraint;
@end

@implementation UCNavBar

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, KIT_SCREEN_WIDTH, KIT_NavBarBottom + 1)];
    if (self) {
        _itemTintColor = [UIColor blueColor];
        _barTintColor = [UIColor whiteColor];
        self.showBottomLine = YES;
        self.backgroundColor = [UIColor clearColor];
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, KIT_NavBarBottom)];
        _bgView.backgroundColor = _barTintColor;
        [self addSubview:_bgView];
    }
    return self;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, KIT_NavBarBottom, self.width, 1)];
        _bottomLine.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (void)setShowBottomLine:(BOOL)showBottomLine
{
    _showBottomLine = showBottomLine;
    self.bottomLine.hidden = !showBottomLine;
}

- (void)setBarAlpha:(CGFloat)barAlpha
{
    _barAlpha = barAlpha;
    self.bgView.alpha = barAlpha;
}

- (void)setTitleAlpha:(CGFloat)titleAlpha
{
    _titleAlpha = titleAlpha;
    self.titleLabel.alpha = titleAlpha;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = self.itemTintColor;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self).offset(kStatusBarHeight / 2);
            make.height.equalTo(self).offset(-KIT_StatusBarHeight);
            make.left.mas_equalTo(40);
            make.right.mas_equalTo(-40);
            make.bottom.equalTo(self);
        }];
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
    if (self.rightBarItems.count>=2) {
      
        if (self.constraint.count>0) {
            return;
        }
          NSInteger width = self.rightBarItems.count*45;
        self.constraint =    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self).offset(-KIT_StatusBarHeight);
            make.left.mas_equalTo(40);
            make.right.offset(-(width));
            make.bottom.equalTo(self);
        }];
    }
}

- (void)setTitleFont:(UIFont *)titleFont{
    self.titleLabel.font = titleFont;
}

- (void)setItemTintColor:(UIColor *)itemTintColor
{
    _itemTintColor = itemTintColor;
    self.titleLabel.textColor = itemTintColor;
    [self.leftBarItems enumerateObjectsUsingBlock:^(UCBarButtonItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        [item setTintColor:self.itemTintColor];
    }];
    
    [self.rightBarItems enumerateObjectsUsingBlock:^(UCBarButtonItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        [item setTintColor:self.itemTintColor];
    }];
    [self setNeedsLayout];
}

- (void)setLeftBarItem:(UCBarButtonItem *)leftBarItem
{
    _leftBarItem = leftBarItem;
    _leftBarItems = @[leftBarItem];
    [self setNeedsLayout];
}

- (void)setRightBarItem:(UCBarButtonItem *)rightBarItem
{
    _rightBarItem = rightBarItem;
    _rightBarItems = @[rightBarItem];
    [self setNeedsLayout];
}

- (void)setBarTintColor:(UIColor *)barTintColor
{
    _barTintColor = barTintColor;
    self.bgView.backgroundColor = barTintColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    __block float leftPadding = 0;//kPadding*kScreenWidthScale;
    [self.leftBarItems enumerateObjectsUsingBlock:^(UCBarButtonItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        [item setTintColor:self.itemTintColor];
        if ([item.customView isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)item.customView;
            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//          [button setImageEdgeInsets:UIEdgeInsetsMake(0, 7 , 0, 0)];
        }
        item.left = leftPadding;
        leftPadding = leftPadding + item.width + item.width>0?5:0;
        if (item.superview == nil) {
            [self addSubview:item];
        }
    }];
    
    //更新按钮的位置
    __block float rightPadding = self.width - 7;
    [self.rightBarItems enumerateObjectsUsingBlock:^(UCBarButtonItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        [item setTintColor:self.itemTintColor];
        if ([item.customView isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)item.customView;
            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        }
        item.right = rightPadding;
        rightPadding = rightPadding - item.width - (item.width>0?5:0);
        if (item.superview == nil) {
            [self addSubview:item];
        }
    }];

    
}

- (UIView *)unreaderMsgCountView{
    UIView *bgview = [[UIView alloc] init];
    
    UCBarButtonItem *messageItem = nil;
    for (UCBarButtonItem *buttonItem in self.rightBarItems) {
        if (buttonItem.itemType == UCBarButtonItemType_Message) {
            messageItem = buttonItem;
            break;
        }
    }
    if (messageItem) {
        CGRect bgVIewFrame = messageItem.frame;
        bgview.frame = CGRectMake(bgVIewFrame.origin.x-10, (-KIT_iPhoneXStatusBarFitHeight) + bgVIewFrame.origin.y - 6, bgVIewFrame.size.width - 12, bgVIewFrame.size.height - 20);
        bgview.userInteractionEnabled = NO;
        //bgview.alpha = 0.01;
        [messageItem  addSubview:bgview];
    }
   
   
    return bgview;
}


@end
