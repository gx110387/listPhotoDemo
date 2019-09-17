//
//  GCJBaseTableCell.m
//  58GuCheJia
//
//  Created by 吴丹 on 2018/3/26.
//  Copyright © 2018年 吴丹. All rights reserved.
//

#import "GCJBaseTableCell.h"
#import "UIColor+Hex.h"

@implementation GCJBaseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setDefaultValue];
    [self createSubViews];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setDefaultValue];
        [self createSubViews];
    }
    return self;
}

- (void)setDefaultValue{
    self.bottomLineHeight = 0;
    self.bottomLineColor = [UIColor colorWithHexString:@"#eaeaea"];
    self.bottomLineLeft = 15;
    self.backgroundColor = [UIColor whiteColor];

    self.rectCorner = kRectCornerNONE;
}

- (void)createSubViews
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   [self roundingCorners:self.rectCorner radius:10];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //画底部线条
    if(self.bottomLineHeight > 0){
        if (self.bottomLineWidth == 0) {
            self.bottomLineWidth = rect.size.width - self.bottomLineLeft;
        }
        CGContextRef context =  UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, rect);
        //下分割线
        CGContextSetStrokeColorWithColor(context, self.bottomLineColor.CGColor);
        CGContextStrokeRect(context, CGRectMake(self.bottomLineLeft, rect.size.height, self.bottomLineWidth, self.bottomLineHeight));

    }
}

//子类实现
- (void)prepareViewWithData:(id)data indexPath:(NSIndexPath *)indexPath
{
    
}

//子类实现
+ (float)computeHeightWithCellData:(id)data
{
    return 0.0;
}

@end
