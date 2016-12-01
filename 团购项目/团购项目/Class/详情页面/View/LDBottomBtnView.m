//
//  LDBottomBtnView.m
//  团购项目
//
//  Created by Ringo on 2016/11/30.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDBottomBtnView.h"

@interface LDBottomBtnView ()
@property(nonatomic,strong)UIButton *buyCarBtn,*buyBtn,*addToBuyCarBtn;//购物车按钮，立即购买按钮，添加到购物车按钮
@end

@implementation LDBottomBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=RGBCOLOR(242, 242, 242);
        [self addSubview:self.buyBtn];
        [self addSubview:self.buyCarBtn];
        [self addSubview:self.addToBuyCarBtn];
    }
    return self;
}

-(UIButton *)addToBuyCarBtn{
    if (!_addToBuyCarBtn) {
        _addToBuyCarBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _addToBuyCarBtn.backgroundColor=[UIColor blueColor];
        
        [_addToBuyCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addToBuyCarBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _addToBuyCarBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [_addToBuyCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _addToBuyCarBtn;
}

-(UIButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn.backgroundColor=[UIColor redColor];
        [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        _buyBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _buyBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
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
        make.height.mas_equalTo(45);
        make.centerY.equalTo(self.mas_centerY);//Y方向居中
        make.left.equalTo(self.buyCarBtn.mas_right).offset(35);
        make.right.equalTo(self.buyBtn.mas_left).offset(-5);
    }];
    
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.centerY.equalTo(self.mas_centerY);//Y方向居中
        make.width.equalTo(self.addToBuyCarBtn.mas_width);
        make.right.equalTo(self.mas_right);
    }];
    
    
    
}

@end
