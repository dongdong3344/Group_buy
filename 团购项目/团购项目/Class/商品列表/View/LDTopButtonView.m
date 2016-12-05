//
//  LDTopButtonView.m
//  团购项目
//
//  Created by Ringo on 2016/12/3.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDTopButtonView.h"

@interface LDTopButtonView ()
@property(nonatomic,strong)UIButton *hotBtn,*priceBtn,*evaluationBtn,*newproductBtn;//热门，价格，好评，新品
@property(nonatomic,strong)UIButton *privousBtn;//记录选中的button
@property(nonatomic,strong)UILabel *lineLabel;
@end

@implementation LDTopButtonView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.hotBtn];
        [self addSubview:self.priceBtn];
        [self addSubview:self.evaluationBtn];
        [self addSubview:self.newproductBtn];
        [self addSubview:self.lineLabel];
        [self addContraints];
    }
    return self;
}

-(void)addContraints{
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36, 2));
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self.hotBtn.mas_centerX);
    }];
    
  
    
}


-(void)clickButton:(UIButton*)sender{
    sender.selected=YES;//当前点击的按钮变成选中状态
    self.privousBtn.selected=NO;//之前被选中的按钮状态变成no
    self.privousBtn=sender;//当前的按钮成为被选中的
    
    
    [_lineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(sender.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(36, 2));
        make.bottom.equalTo(self.mas_bottom);
    
      [UIView animateWithDuration:0.5 animations:^{
          [self layoutIfNeeded];
          
        }];

    }];
    
    
}
-(UIButton *)hotBtn{
    if (!_hotBtn) {
        _hotBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _hotBtn.frame=CGRectMake(0, 0, SCREEN_WITH/4, 30);
        _hotBtn.titleLabel.font=[UIFont systemFontOfSize:18];
        [_hotBtn setTitle:@"热门" forState:UIControlStateNormal];
        [_hotBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_hotBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _hotBtn.selected=YES;
        self.privousBtn=_hotBtn;
        [_hotBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hotBtn;
}

-(UIButton *)priceBtn{
    if (!_priceBtn) {
        _priceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _priceBtn.frame=CGRectMake(SCREEN_WITH/4, 0, SCREEN_WITH/4, 30);
        _priceBtn.titleLabel.font=[UIFont systemFontOfSize:18];
        [_priceBtn setTitle:@"价格" forState:UIControlStateNormal];
        [_priceBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_priceBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_priceBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _priceBtn;
}

-(UIButton *)evaluationBtn{
    if (!_evaluationBtn) {
        _evaluationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _evaluationBtn.frame=CGRectMake(2*SCREEN_WITH/4, 0, SCREEN_WITH/4, 30);
        [_evaluationBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _evaluationBtn.titleLabel.font=[UIFont systemFontOfSize:18];
        [_evaluationBtn setTitle:@"好评" forState:UIControlStateNormal];
        [_evaluationBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_evaluationBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaluationBtn;
}


-(UIButton *)newproductBtn{
    if (!_newproductBtn) {
        _newproductBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _newproductBtn.frame=CGRectMake(3*SCREEN_WITH/4, 0, SCREEN_WITH/4, 30);
        [_newproductBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _newproductBtn.titleLabel.font=[UIFont systemFontOfSize:18];
        [_newproductBtn setTitle:@"新品" forState:UIControlStateNormal];
        [_newproductBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_newproductBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _newproductBtn;
}


-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel=[[UILabel alloc]init];
        _lineLabel.backgroundColor=[UIColor redColor];
    }
    return _lineLabel;
}
@end
