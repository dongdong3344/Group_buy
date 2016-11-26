//
//  LDButtonSwitchView.m
//  团购项目
//
//  Created by Ringo on 2016/11/26.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDButtonSwitchView.h"

@interface LDButtonSwitchView ()


@end

@implementation LDButtonSwitchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.productBtn];
        [self addSubview:self.brandBtn];
    }
    return self;
}



//新品团购按钮
-(UIButton *)productBtn{
    if (!_productBtn) {
        _productBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_productBtn setImage:[UIImage imageNamed:@"product_un"] forState:UIControlStateNormal];
        [_productBtn setImage:[UIImage  imageNamed:@"product"] forState:UIControlStateSelected];
        [_productBtn setTitle:@"新品团购" forState:UIControlStateNormal];
        [_productBtn setTitleColor:RGBCOLOR(56, 166, 243) forState:UIControlStateNormal];
        [_productBtn setTitleColor:RGBCOLOR(213, 48, 34) forState:UIControlStateSelected];
        _productBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        
        [_productBtn addTarget:self action:@selector(changeTableView:) forControlEvents:UIControlEventTouchUpInside];
        _productBtn.frame=CGRectMake(0, 0, SCREEN_WITH/2, 50);
        _productBtn.selected=YES;
        
    }
    return _productBtn;
    
}

//品牌团购按钮
-(UIButton *)brandBtn{
    if (!_brandBtn) {
        _brandBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_brandBtn setImage:[UIImage imageNamed:@"brand_un"] forState:UIControlStateNormal];
        [_brandBtn setImage:[UIImage  imageNamed:@"brand"] forState:UIControlStateSelected];
        _brandBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_brandBtn setTitle:@"品牌团购" forState:UIControlStateNormal];
        
        [_brandBtn setTitleColor:RGBCOLOR(56, 166, 243) forState:UIControlStateNormal];
        [_brandBtn setTitleColor: RGBCOLOR(213, 48, 34) forState:UIControlStateSelected];
        
        _brandBtn.frame=CGRectMake(SCREEN_WITH/2, 0, SCREEN_WITH/2, 50);
        
        [_brandBtn addTarget:self action:@selector(changeTableView:) forControlEvents:UIControlEventTouchUpInside];
        
        _brandBtn.selected=NO;
        
    }
    return _brandBtn;
    
}


@end
