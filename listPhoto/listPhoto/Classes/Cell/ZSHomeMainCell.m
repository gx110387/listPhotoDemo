//
//  ZSHomeMainCell.m
//  listPhoto
//
//  Created by     gaoxing on 2019/9/16.
//  Copyright © 2019 gaoxing. All rights reserved.
//

#import "ZSHomeMainCell.h"
#import "ZSHomeDataModel.h"
#import "UIView+Corner.h"
#import "UIColor+Hex.h"
#import "SDPhotoBrowser.h"
@interface ZSHomeMainCell()<SDPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backImageV;
@property (weak, nonatomic) IBOutlet UIImageView *personImageV;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *bottomTitleL;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong)  ZSHomeDataModel *model;
@property (weak, nonatomic) IBOutlet UILabel *sizeL;
@property (weak, nonatomic) IBOutlet UILabel *likeL;
@property (weak, nonatomic) IBOutlet UILabel *userNameL;

@end

@implementation ZSHomeMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)createSubViews{
    self.bottomLineHeight = 1;
    self.bottomLineWidth = SCREEN_WIDTH-30;
    self.bottomLineLeft = 15;
    self.backImageV.frame = CGRectMake(15, 15, SCREEN_WIDTH-30, 250);
    self.bottomView.frame = CGRectMake(15, 280-15-55, SCREEN_WIDTH-30, 55);
    
    [self.backImageV roundingCorners:UIRectCornerAllCorners radius:10];
    [self.personImageV roundingCorners:UIRectCornerAllCorners radius:45/2];
    [self.bottomView roundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight radius:10];
    self.bottomView.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.3];
    self.backImageV.userInteractionEnabled = YES;
    [self.backImageV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapGestAction:)]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)prepareViewWithData:(id)data indexPath:(NSIndexPath *)indexPath{
    if (data && [data isKindOfClass:ZSHomeDataModel.class]) {
        self.indexPath = indexPath;
        ZSHomeDataModel *model = (ZSHomeDataModel *)data;
        self.model = model;
        [self.backImageV sd_setImageWithURL:[NSURL URLWithString:model.urls.small]];
      NSString *personUrl =   model.user[@"profile_image"][@"small"];
        if (personUrl) {
        [self.personImageV sd_setImageWithURL:[NSURL URLWithString:personUrl]];
        }
        NSString *location = [model.user[@"location"] isEqual: [NSNull null]]?@"":[model.user[@"location"] description];
        if (location.length>0) {
             self.sizeL.text = [NSString stringWithFormat:@"地点:%@",location];
        }
       
        self.likeL.text = [NSString stringWithFormat:@"喜欢 %@",model.likes];
        self.bottomTitleL.text = model.content;
        self.userNameL.text = [NSString stringWithFormat:@"%@",self.model.user[@"username"]];
    }
    
}
+(float)computeHeightWithCellData:(id)data{
    return 280;
}
-(void)onTapGestAction:(UITapGestureRecognizer *)tapView{
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = 0;
    browser.sourceImagesContainerView = self.contentView;
    browser.imageCount = 1;
    browser.delegate = self;
    [browser show];
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *url = self.model.urls.full;
    
    NSURL *imageUrl = [NSURL URLWithString:url];
    return imageUrl;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    
    return self.backImageV.image;
}
@end
