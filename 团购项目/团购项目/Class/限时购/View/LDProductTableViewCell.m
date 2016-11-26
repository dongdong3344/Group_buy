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

        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.pricLabel];
        [self addSubview:self.buyCarBtn];
        
    }
    return  self;
}

//重写set方法
-(void)setProductEntiy:(LDProductEntity *)productEntiy{
    
     _productEntiy=productEntiy;
    _titleLabel.text=productEntiy.Title;
    _contentLabel.text = productEntiy.GoodsIntro;//icon_placeholder
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:self.productEntiy.ImgView] placeholderImage:[UIImage imageNamed:@"icon_placeholder"]];
      //_pricLabel.text=[NSString stringWithFormat:@"￥:%@,%@",productEntiy.DomesticPrice,productEntiy.Price];
    [self priceAttributedString];
}

- (void)priceAttributedString{
    
    NSString *price=[NSString stringWithFormat:@"%@ ",self.productEntiy.Price];
    NSMutableAttributedString   *priceStr=[[NSMutableAttributedString alloc]initWithString:price attributes:@{NSForegroundColorAttributeName:RGBCOLOR(230, 50, 37),NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    
    
    NSString *domesticPrice=[NSString stringWithFormat:@"￥%@",self.productEntiy.DomesticPrice];
    NSMutableAttributedString   *domesticPriceStr =[[NSMutableAttributedString alloc]initWithString:domesticPrice attributes:@{NSForegroundColorAttributeName:RGBCOLOR(132, 132, 132),NSFontAttributeName:[UIFont systemFontOfSize:12],NSStrikethroughStyleAttributeName:@(2),NSStrikethroughColorAttributeName:[UIColor grayColor]}];
    
    [priceStr insertAttributedString:domesticPriceStr atIndex:price.length];
    self.pricLabel.attributedText=priceStr;
  

    
}


- (void)layoutSubviews{
    [super layoutSubviews];
  
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(140, 140));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(5);
    }];
    

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.left.equalTo(self.iconImage.mas_right).offset(6);
        make.top.equalTo(self.mas_top).offset(25);
        make.height.equalTo(@15);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(7);
        make.right.equalTo(self.mas_right).offset(-15);
        make.left.equalTo(self.iconImage.mas_right).offset(6);
        make.height.equalTo(@60);
    }];
    
    [_pricLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.left.equalTo(self.iconImage.mas_right).offset(6);
        make.right.equalTo(self.buyCarBtn.mas_left).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-23);
    }];
    
    [_buyCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(37, 37));
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
        _iconImage.layer.cornerRadius=5;
        _iconImage.clipsToBounds=YES;
    }
    return _iconImage;
}



- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _titleLabel.textColor = [UIColor orangeColor];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor =[UIColor blackColor];
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
        [_buyCarBtn setImage:[UIImage imageNamed:@"buycar_btn"] forState:(UIControlStateNormal)];
    }
    return _buyCarBtn;
}





@end
