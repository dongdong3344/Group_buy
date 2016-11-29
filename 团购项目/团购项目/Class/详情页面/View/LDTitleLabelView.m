//
//  LDTitleLabelView.m
//  团购项目
//
//  Created by Ringo on 2016/11/28.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDTitleLabelView.h"

@interface LDTitleLabelView ()
@property(strong,nonatomic)UILabel *titleLabel,*priceLabel,*separatorLineLabel,*contentLabel,*shopName,*countryName;//标题,价格,分割线,内容标签,商店名称
@property(strong,nonatomic)UIButton * clickToViewProductBtn;
@property(strong,nonatomic)UIImageView *shopIcon,*countryIcon,*nextBtnImage;
@end

@implementation LDTitleLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.separatorLineLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.clickToViewProductBtn];
        [self addSubview:self.shopName];
        [self addSubview:self.countryName];
        [self addSubview:self.shopIcon];
        [self addSubview:self.countryIcon];
        [self addSubview:self.nextBtnImage];
    }
    return self;
}


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.font=[UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _priceLabel;
}

-(UILabel *)separatorLineLabel{
    if (!_separatorLineLabel) {
        _separatorLineLabel=[[UILabel alloc]init];
        _separatorLineLabel.backgroundColor=RGBCOLOR(242, 242, 242);
    }
    return _separatorLineLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc]init];
        _contentLabel.font=[UIFont systemFontOfSize:13];
        _contentLabel.textColor=RGBCOLOR(83, 83, 83);
    }
    return _contentLabel;
}

-(UILabel *)shopName{
    if (!_shopName) {
        _shopName=[[UILabel alloc]init];
        _shopName.font=[UIFont systemFontOfSize:13];
    }
    return _shopName;
}


-(UILabel *)countryName{
    if (!_countryName) {
        _countryName=[[UILabel alloc]init];
        _countryName.font=[UIFont systemFontOfSize:13];
    }
    return _countryName;
}

-(UIImageView *)shopIcon{
    if (!_shopIcon) {
        _shopIcon=[[UIImageView alloc]init];
    }
    return _shopIcon;
}


-(UIImageView *)countryIcon{
    if (!_countryIcon) {
        _countryIcon=[[UIImageView alloc]init];
    }
    return _countryIcon;
}


-(UIImageView *)nextBtnImage{
    if (!_nextBtnImage) {
        _nextBtnImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"next"]];
        
    }
    return _nextBtnImage;
}
-(UIButton *)clickToViewProductBtn{
    if (!_clickToViewProductBtn) {
        _clickToViewProductBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _clickToViewProductBtn.backgroundColor=[UIColor whiteColor];
        
    }
    return _clickToViewProductBtn;
}


-(void)layoutSubviews{
    
    
}
@end
