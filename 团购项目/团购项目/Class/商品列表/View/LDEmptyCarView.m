//
//  LDEmptyCarView.m
//  团购项目
//
//  Created by Ringo on 2016/12/6.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDEmptyCarView.h"

@interface LDEmptyCarView ()
@property(nonatomic,strong)UIImageView *buycarView;
@property(nonatomic,strong)UILabel *label;

@end

@implementation LDEmptyCarView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.buycarView];
        [self addSubview:self.label];
        [self addSubview:self.goShopBtn];
        [self addSubview:self.collectionBtn];
    }
    return self;
}

-(UIImageView *)buycarView{
    if (!_buycarView) {
        _buycarView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cart01"]];
    }
    return _buycarView;
}

-(UILabel *)label{
    if (!_label) {
        _label=[[UILabel alloc]init];
        _label.text=@"您的购物车中没有商品";
        _label.font=[UIFont systemFontOfSize:16];
        _label.textColor=RGBCOLOR(85, 85, 85);
        _label.textAlignment=NSTextAlignmentCenter;
    }
    return _label;
}


-(UIButton *)goShopBtn{
    if (!_goShopBtn) {
        _goShopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_goShopBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
        _goShopBtn.backgroundColor=RGBCOLOR(18, 99, 177);
        _goShopBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [_goShopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _goShopBtn.layer.cornerRadius=5;
        
     
        
    }
    return _goShopBtn;
}


-(UIButton *)collectionBtn{
    if (!_collectionBtn) {
        _collectionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_collectionBtn setTitle:@"看收藏" forState:UIControlStateNormal];
        _collectionBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _collectionBtn.backgroundColor=RGBCOLOR(18, 99, 177);
        
        [_collectionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        // [_collectionBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        _collectionBtn.layer.cornerRadius=5;
    }
    return _collectionBtn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    [_buycarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(179, 155));
        make.top.equalTo(self.mas_top).offset(20);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 16));
        make.top.equalTo(self.buycarView.mas_bottom).offset(20);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    [_goShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-50);
        make.left.equalTo(self.mas_left).offset(50);
        make.top.equalTo(self.buycarView.mas_bottom).offset(80);
        make.height.equalTo(@35);
    }];
    
    
    [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-50);
        make.left.equalTo(self.mas_left).offset(50);
        make.top.equalTo(self.goShopBtn.mas_bottom).offset(25);
        make.height.equalTo(@35);
    }];

    
}

@end
