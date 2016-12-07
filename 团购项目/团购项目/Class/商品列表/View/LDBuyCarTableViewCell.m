//
//  LDBuyCarTableViewCell.m
//  团购项目
//
//  Created by Ringo on 2016/12/5.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDBuyCarTableViewCell.h"

@interface LDBuyCarTableViewCell ()
@property(strong,nonatomic)UILabel *titleLabel, *priceLabel,*buyCountLabel;

@property(strong,nonatomic)UIImageView *bgImgView,*productImgView;//加减背景
@end

@implementation LDBuyCarTableViewCell

//注意是initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier方法！！！
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
     //   self.userInteractionEnabled=NO;//不让点击
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.buyCountLabel];
        [self addSubview:self.isSelectedBtn];
        [self addSubview:self.productImgView];
        [self addSubview:self.bgImgView];
        [self addSubview:self.plusBtn];
        [self addSubview:self.minusBtn];
  
    }
    return self;
}

/***setter***/
-(void)setBuycarEntity:(LDBuyCarEntity *)buycarEntity{
    
    _buycarEntity=buycarEntity;
    self.titleLabel.text=buycarEntity.GoodsTitle;
    self.priceLabel.text=[NSString stringWithFormat:@"￥%.2lf",buycarEntity.Price];
    self.buyCountLabel.text=[NSString stringWithFormat:@"%ld",(long)buycarEntity.GoodsCount];
    [self.productImgView sd_setImageWithURL:[NSURL URLWithString:buycarEntity.ImgView] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.isSelectedBtn.selected=buycarEntity.isSelectButton;
}


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=[UIFont systemFontOfSize:14];
        _titleLabel.textColor=[UIColor blackColor];
    }
    return _titleLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.font=[UIFont systemFontOfSize:14];
        _priceLabel.textColor=[UIColor orangeColor];
    }
    return _priceLabel;
    
}

-(UILabel *)buyCountLabel{
    if (!_buyCountLabel) {
        _buyCountLabel=[[UILabel alloc]init];
        _buyCountLabel.font=[UIFont systemFontOfSize:11];
        _buyCountLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _buyCountLabel;
}


-(UIButton *)isSelectedBtn{
    if (!_isSelectedBtn) {
        _isSelectedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
       
        [_isSelectedBtn setImage:[UIImage imageNamed:@"product_un"] forState:UIControlStateNormal];
        [_isSelectedBtn setImage:[UIImage imageNamed:@"product_selected"] forState:UIControlStateSelected];
       //  _isSelectedBtn.selected=YES;
    }
    return _isSelectedBtn;
}

-(UIButton *)plusBtn{
    if (!_plusBtn) {
        _plusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _plusBtn.backgroundColor=[UIColor clearColor];
    }
    return _plusBtn;
}

-(UIButton *)minusBtn{
    if (!_minusBtn) {
        _minusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _minusBtn.backgroundColor=[UIColor clearColor];
    }
    return _minusBtn;
}

-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"plus_minus"]];
    }
    return _bgImgView;
}


-(UIImageView *)productImgView{
    if (!_productImgView) {
        _productImgView=[[UIImageView alloc]init];
    }
    return _productImgView;
}

/***添加约束***/
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_isSelectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(12);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.mas_centerY);//Y方向居中
    }];
    
    [_productImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);//Y方向居中
        make.size.mas_equalTo(CGSizeMake(53, 53));
        make.left.equalTo(self.isSelectedBtn.mas_right).offset(8);
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.productImgView.mas_top);
        make.left.equalTo(self.productImgView.mas_right).offset(18);
        make.height.mas_equalTo(14);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@13);
        make.left.equalTo(self.productImgView.mas_right).offset(18);
        make.right.equalTo(self.bgImgView.mas_left).offset(-20);
        make.bottom.equalTo(self.productImgView.mas_bottom).offset(-7);
    }];
    
    [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-18);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(85, 25));
    }];
    
    [_minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.top.equalTo(self.bgImgView);
    }];
    
    [_plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.top.equalTo(self.bgImgView);
    }];
    
    [_buyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.bgImgView);
        make.width.mas_equalTo(35);
        make.centerX.equalTo(self.bgImgView.mas_centerX);
    }];
    
    
}


@end
