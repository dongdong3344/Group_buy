//
//  LDCheckoutView.m
//  团购项目
//
//  Created by Ringo on 2016/12/6.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDCheckoutView.h"

@interface LDCheckoutView ()
@property(strong,nonatomic)UILabel *hintLabel;
@property(strong,nonatomic)UIButton *gotoCheckoutBtn;

@end

@implementation LDCheckoutView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.priceLabel];
        [self addSubview:self.hintLabel];
        [self addSubview:self.gotoCheckoutBtn];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}


-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel=[[UILabel alloc]init];
        _priceLabel.font=[UIFont systemFontOfSize:14];
        _priceLabel.textColor=[UIColor blackColor];
        
    }
    return _priceLabel;
}


-(UILabel *)hintLabel{
    if (!_hintLabel) {
        _hintLabel=[[UILabel alloc]init];
        _hintLabel.text=@"满199元，全场包邮";
        _hintLabel.textColor=[UIColor redColor];
        _hintLabel.font=[UIFont systemFontOfSize:14];
    }
    return _hintLabel;
}


-(UIButton *)gotoCheckoutBtn{
    if (!_gotoCheckoutBtn) {
        _gotoCheckoutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_gotoCheckoutBtn setTitle:@"结算" forState:UIControlStateNormal];
        [_gotoCheckoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _gotoCheckoutBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _gotoCheckoutBtn.backgroundColor=[UIColor redColor];
    }
    return _gotoCheckoutBtn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(17);
        make.right.equalTo(self.gotoCheckoutBtn.mas_left).offset(-20);
    }];
    
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(140, 14));
        make.left.equalTo(self.mas_left).offset(10);
        
    }];
    
    [_gotoCheckoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 45));
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];

}
@end
