//
//  LDTitleLabelView.m
//  团购项目
//
//  Created by Ringo on 2016/11/28.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDTitleLabelView.h"

@interface LDTitleLabelView ()
@property(strong,nonatomic)UILabel *titleLabel,*priceLabel,*separatorLineLabel,*contentLabel,*countryName,*hintLabel,*hintLineLabel,*shopName;//标题,价格,分割线,内容标签,国家名称，提示标签,商店名称；
@property(strong,nonatomic)UIButton * clickToViewProductBtn;//查看产品按钮
@property(strong,nonatomic)UIImageView *shopIcon,*countryIcon,*nextBtnImage;//产品图片，国旗，向右箭头图片
@property(strong,nonatomic)UIView *bgView;//背景
@end

@implementation LDTitleLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=RGBCOLOR(242, 242, 242);
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.separatorLineLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.clickToViewProductBtn];
        [self addSubview:self.shopName];
        [self addSubview:self.bgView];
        [self addSubview:self.countryName];
        [self addSubview:self.shopIcon];
        [self addSubview:self.countryIcon];
        [self addSubview:self.nextBtnImage];
        [self addSubview:self.hintLabel];
        [self addSubview:self.hintLineLabel];
        [self addConstraint];//添加约束条件
     
    }
    return self;
}

#pragma mark - 重写set方法-
-(void)setTitleEntity:(LDTitleEntity *)titleEntity{
    
    CGFloat viewHeight=210;
    
    _titleEntity=titleEntity;
    self.titleLabel.text=titleEntity.Abbreviation;
 
    CGFloat titleLabelHeight=[self returnLabelHeight:titleEntity.Abbreviation size:CGSizeMake(SCREEN_WITH-60, MAXFLOAT) fontSize:[UIFont boldSystemFontOfSize:16]];
    
    //更新title label高度
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(titleLabelHeight);
    }];
    
 
    
    self.contentLabel.text=titleEntity.GoodsIntro;
    CGFloat contentLabelHeight=[self returnLabelHeight:titleEntity.GoodsIntro size:CGSizeMake(SCREEN_WITH-30, MAXFLOAT) fontSize:[UIFont systemFontOfSize:14]];
    
    //更新content label高度
    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(contentLabelHeight);
    }];

    [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:titleEntity.ShopImage] placeholderImage:nil];
    self.shopName.text=titleEntity.BrandCNName;
    //LDDLog(@"shopName:%@",self.shopName.text);
    //self.countryName.text=titleEntity.CountryName;
    
    //block
    if (self.titleLabelViewBlock) {
        self.titleLabelViewBlock(viewHeight+titleLabelHeight+contentLabelHeight);
    }
    
       //self.priceLabel.text=[NSString stringWithFormat:@"%@ %@ %@",titleEntity.Price,titleEntity.OriginalPrice,titleEntity.Discount];
    [self priceAttributedString];

}

- (void)priceAttributedString{
   
    NSString *price=[NSString stringWithFormat:@"%@ ",self.titleEntity.Price];
    NSMutableAttributedString *priceStr=[[NSMutableAttributedString alloc]initWithString:price attributes:@{NSForegroundColorAttributeName:RGBCOLOR(230, 50, 37),NSFontAttributeName:[UIFont boldSystemFontOfSize:24]}];
    
    
    NSString *originalPrice=[NSString stringWithFormat:@"%@ ",self.titleEntity.OriginalPrice];
    NSMutableAttributedString *originalPriceStr =[[NSMutableAttributedString alloc]initWithString:originalPrice attributes:@{NSForegroundColorAttributeName:RGBCOLOR(132, 132, 132),NSFontAttributeName:[UIFont systemFontOfSize:18],NSStrikethroughStyleAttributeName:@(2),NSStrikethroughColorAttributeName:[UIColor grayColor]}];
    
     [priceStr insertAttributedString:originalPriceStr atIndex:price.length];
    
    self.priceLabel.attributedText=priceStr;
    
}

-(CGFloat)returnLabelHeight:(NSString *)string
                       size:(CGSize)size
                   fontSize:(UIFont*)font{
    CGFloat height=[string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height ;//自适应高度
    return height;
}

-(UILabel *)hintLabel{
    if (!_hintLabel) {
        _hintLabel=[[UILabel alloc]init];
        _hintLabel.text=@"图文详情";
        _hintLabel.font=[UIFont systemFontOfSize:14];
    }
    return _hintLabel;
}


-(UILabel *)hintLineLabel{
    if (!_hintLineLabel) {
        _hintLineLabel=[[UILabel alloc]init];
        _hintLineLabel.backgroundColor=RGBCOLOR(242, 242, 242);
        //RGBCOLOR(242, 242, 242);
    }
    return _hintLineLabel;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.textAlignment=NSTextAlignmentLeft;
        _titleLabel.font=[UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines=0;
    }
    return _titleLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.textAlignment=NSTextAlignmentCenter;
        
        _priceLabel.textColor=[UIColor blackColor];
    }
    return _priceLabel;
}

-(UILabel *)separatorLineLabel{
    if (!_separatorLineLabel) {
        _separatorLineLabel=[[UILabel alloc]init];
        _separatorLineLabel.backgroundColor=RGBCOLOR(242, 242, 242);
        //RGBCOLOR(242, 242, 242);
    }
    return _separatorLineLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[UILabel alloc]init];
        _contentLabel.font=[UIFont systemFontOfSize:13];
      
        _contentLabel.textColor=RGBCOLOR(83, 83, 83);
        _contentLabel.numberOfLines=0;
    }
    return _contentLabel;
}


-(UIView *)bgView{
    if (!_bgView) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=[UIColor whiteColor];
    }
    return _bgView;
}

-(UILabel *)shopName{
    if (!_shopName) {
        _shopName=[[UILabel alloc]init];
        _shopName.font=[UIFont systemFontOfSize:13];
        _shopName.backgroundColor=[UIColor orangeColor];
        
        //LDDLog(@"shopName frame:%@",NSStringFromCGRect(self.shopName.frame));
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
        _shopIcon.contentMode=UIViewContentModeScaleAspectFit;//设置图片不变形
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

#pragma mark ——添加约束——

-(void)addConstraint{

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.mas_top);  //标题高度不确定，高度需要更新约束
        make.height.mas_equalTo(20);
      }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(25);
        make.right.left.equalTo(self);
    }];
    
    [_separatorLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.right.equalTo(self.mas_right).offset(-15);
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(25);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.separatorLineLabel).offset(20);
        //标题高度不确定，高度需要更新约束
        make.height.mas_equalTo(20);
    }];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(18);
    }];
    
    [_clickToViewProductBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgView).with.insets(UIEdgeInsetsMake(10, 0, 10, 0));
    }];
    
    [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.clickToViewProductBtn.mas_left).offset(15);
        make.centerY.equalTo(self.clickToViewProductBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopIcon.mas_top).offset(5);
        make.left.equalTo(self.shopIcon.mas_right).offset(15);
        make.height.mas_equalTo(12);
        make.right.equalTo(self.mas_right).offset(-120);
    }];
   
    [_countryIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18, 13));
        make.left.equalTo(self.shopIcon.mas_right).offset(15);
        make.bottom.equalTo(self.shopIcon.mas_bottom).offset(-5);
    }];
    
    [_countryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.countryIcon.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70, 15));
        make.left.equalTo(self.countryIcon.mas_right).offset(5);
    }];
    
    [_nextBtnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 15));
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.shopIcon.mas_centerY);
    }];
    
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 50));
        make.top.equalTo(self.bgView.mas_bottom);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    
    [_hintLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.equalTo(self.hintLabel.mas_bottom);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        
    }];
    
  
}
@end
