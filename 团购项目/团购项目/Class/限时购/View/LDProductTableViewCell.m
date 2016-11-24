//
//  LDProductTableViewCell.m
//  团购项目
//
//  Created by Ringo on 2016/11/24.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDProductTableViewCell.h"


@interface LDProductTableViewCell ()
@property (strong, nonatomic)   UIImageView *iconImage;              /** 图片 */
@property (strong, nonatomic)   UIImageView *countryImage;         /** 国旗 */
@property (strong, nonatomic)   UILabel *titleLabel;                    /** 标题label */
@property (strong, nonatomic)   UILabel *contentLabel;              /** 内容 */
@property (strong, nonatomic)   UILabel *pricLabel;                   /** 价格label */
@property (strong, nonatomic)   UIButton *buyCarBtn;              /** 购物车按钮 */
@end

@implementation LDProductTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.countryImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.pricLabel];
        [self addSubview:self.buyCarBtn];
        
    }
    return  self;
}


-(void)setProductEntiy:(LDProductEntity *)productEntiy{
    
  //  _productEntiy=productEntiy;
    _titleLabel.text=productEntiy.title;
     _contentLabel.text = productEntiy.goodsIntro;
    
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(140, 140));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(5);
    }];
    
    [_countryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 20));
        make.left.equalTo(weakSelf.iconImage.mas_left).offset(8);
        make.top.equalTo(weakSelf.iconImage.mas_top).offset(8);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(6);
        make.top.equalTo(weakSelf.mas_top).offset(25);
        make.height.equalTo(@15);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(7);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(6);
        make.height.equalTo(@60);
    }];
    
    [_pricLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(6);
        make.right.equalTo(weakSelf.buyCarBtn.mas_left).offset(-20);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-23);
    }];
    
    [_buyCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(37, 37));
        make.right.equalTo(weakSelf.mas_right).offset(-45);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-20);
    }];
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
    }
    return _iconImage;
}

- (UIImageView *)countryImage{
    if (!_countryImage) {
        _countryImage = [[UIImageView alloc]init];
    }
    return _countryImage;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _titleLabel.textColor = [UIColor redColor];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = RGBCOLOR(35, 35, 35);
        _contentLabel.font = [UIFont systemFontOfSize:13.0];
        _contentLabel.numberOfLines = 3;
    }
    return _contentLabel;
}

- (UILabel *)pricLabel{
    if (!_pricLabel) {
        _pricLabel = [[UILabel alloc]init];
    }
    return _pricLabel;
}

- (UIButton *)buyCarBtn{
    if (!_buyCarBtn) {
        _buyCarBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_buyCarBtn setImage:[UIImage imageNamed:@"car"] forState:(UIControlStateNormal)];
    }
    return _buyCarBtn;
}





@end
