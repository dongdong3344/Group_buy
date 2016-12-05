//
//  LDGoodsCollectionViewCell.m
//  团购项目
//
//  Created by Ringo on 2016/12/3.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDGoodsCollectionViewCell.h"

@interface LDGoodsCollectionViewCell ()
@property(strong,nonatomic)UIImageView *countryImg,*productImg;
@property(strong,nonatomic)UILabel *titleLabel,*priceLabel;

@end

@implementation LDGoodsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.countryImg];
        [self addSubview:self.priceLabel];
        [self addSubview:self.productImg];
        [self addSubview:self.titleLabel];
    }
    return self;
}


-(void)setGoodsListEntity:(LDGoodsListEntity *)goodsListEntity{
    _goodsListEntity=goodsListEntity;
    _titleLabel.text=goodsListEntity.Title;
    [_countryImg sd_setImageWithURL:[NSURL URLWithString:goodsListEntity.CountryImg] placeholderImage:[UIImage imageNamed:@"placeholder"]];

    [_productImg sd_setImageWithURL:[NSURL URLWithString:goodsListEntity.ImgView] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    _priceLabel.text=[NSString stringWithFormat:@"%@ ￥%@",goodsListEntity.Price,goodsListEntity.DomesticPrice];
    
}
-(UIImageView *)countryImg{
    if (!_countryImg) {
        _countryImg=[[UIImageView alloc]init];
    }
    return _countryImg;
}

-(UIImageView *)productImg{
    if (!_productImg) {
        _productImg=[[UIImageView alloc]init];
    }
    return _productImg;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=[UIFont systemFontOfSize:14];
        _titleLabel.numberOfLines=2;
    }
    return _titleLabel;
}


-(UILabel *)priceLabel{
    
    if (!_priceLabel) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.font=[UIFont systemFontOfSize:14];
        _priceLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _priceLabel;
}


-(void)layoutSubviews{
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-80);
    }];
    
    [_countryImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22, 16));
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_bottom).offset(11);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(11);
        make.right.equalTo(self.mas_right).offset(-11);
        make.top.equalTo(self.productImg.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
        
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(11);
        make.right.equalTo(self.mas_right).offset(-11);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(15);

    }];
    
}
@end
