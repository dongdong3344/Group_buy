//
//  LDBottomBtnView.m
//  团购项目
//
//  Created by Ringo on 2016/11/30.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDBottomBtnView.h"

@interface LDBottomBtnView ()
@property(nonatomic,strong)UIButton *buyCarBtn,*buyBtn,*addToBuyCarBtn;
@end

@implementation LDBottomBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.buyBtn];
        [self addSubview:self.buyCarBtn];
        [self addSubview:self.addToBuyCarBtn];
        self.backgroundColor=[UIColor orangeColor];
    }
    return self;
}

-(UIButton *)addToBuyCarBtn{
    if (!_addToBuyCarBtn) {
        _addToBuyCarBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _addToBuyCarBtn.backgroundColor=[UIColor redColor];
        _addToBuyCarBtn.titleLabel.text=@"加入购物车";
        _addToBuyCarBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_addToBuyCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _addToBuyCarBtn;
}

-(UIButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn.backgroundColor=[UIColor blueColor];
        _buyBtn.titleLabel.text=@"立即购买";
        _buyBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
    return _buyBtn;
}

-(UIButton *)buyCarBtn{
    if (!_buyCarBtn) {
        _buyCarBtn=[UIButton buttonWithType: UIButtonTypeCustom];
        [_buyCarBtn setImage:[UIImage imageNamed:@"shoppingcar"] forState:UIControlStateNormal];
    }
    return _buyCarBtn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_buyCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(26, 26));
        make.centerY.equalTo(self.mas_centerY);//Y方向居中
        
    }];
    
    [_addToBuyCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(70);
        make.centerY.equalTo(self.mas_centerY);//Y方向居中
        make.left.equalTo(self.buyCarBtn.mas_right).offset(35);
        make.right.equalTo(self.buyBtn.mas_left).offset(30);
    }];
    
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(70);
        make.centerY.equalTo(self.mas_centerY);//Y方向居中
        make.width.equalTo(self.addToBuyCarBtn.mas_width);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    
    
}

@end
