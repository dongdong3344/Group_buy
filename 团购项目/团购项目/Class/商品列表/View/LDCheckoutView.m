//
//  LDCheckoutView.m
//  团购项目
//
//  Created by Ringo on 2016/12/6.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDCheckoutView.h"
#import "LDBuyCarEntity.h"

@interface LDCheckoutView ()
@property(strong,nonatomic)UILabel *hintLabel,*totalLabel;


@end

@implementation LDCheckoutView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.priceLabel];
        [self addSubview:self.hintLabel];
        [self addSubview:self.gotoCheckoutBtn];
        [self addSubview:self.selectAllBtn];
        [self addSubview:self.totalLabel];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}


-(void)setBuycarEntity:(LDBuyCarEntity *)buycarEntity{
    self.selectAllBtn.selected=buycarEntity.isSelectAllButton;
}

-(UIButton *)selectAllBtn{
    if (!_selectAllBtn) {
        _selectAllBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_selectAllBtn setImage:[UIImage imageNamed:@"product_un"] forState:UIControlStateNormal];
        [_selectAllBtn setImage:[UIImage imageNamed:@"product_selected"] forState:UIControlStateSelected];

    }
    return _selectAllBtn;
}


-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.font=[UIFont systemFontOfSize:14];
        _priceLabel.textColor=[UIColor blackColor];
        
    }
    return _priceLabel;
}


-(UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel=[[UILabel alloc]init];
        _totalLabel.font=[UIFont systemFontOfSize:16];
        _totalLabel.textColor=[UIColor blackColor];
        _totalLabel.text=@"全选";

    }
    return _totalLabel;
}

-(UILabel *)hintLabel{
    if (!_hintLabel) {
        _hintLabel=[[UILabel alloc]init];
        _hintLabel.text=@"满199元，全场包邮";
        _hintLabel.textColor=[UIColor blackColor];
        _hintLabel.font=[UIFont systemFontOfSize:14];
    }
    return _hintLabel;
}


-(UIButton *)gotoCheckoutBtn{
    if (!_gotoCheckoutBtn) {
        _gotoCheckoutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_gotoCheckoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _gotoCheckoutBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
        _gotoCheckoutBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return _gotoCheckoutBtn;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [_selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        
    }];
    
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectAllBtn.mas_right).offset(5);
        make.centerY.equalTo(self.mas_centerY);
        make.top.equalTo(self.mas_top).offset(10);
       

    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(90);
        make.size.mas_equalTo(CGSizeMake(140, 20));
        

    }];
    
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(140, 14));
        make.left.equalTo(self.mas_left).offset(90);
        
    }];
    
    [_gotoCheckoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 55));
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];

}
@end
