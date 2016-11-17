//
//  LDMyMessageHeadView.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDMyMessageHeadView.h"

@interface LDMyMessageHeadView()

@property(nonatomic,strong)UIImageView *headBackIamge;
@property(nonatomic,strong)UIButton *loginBtn, *registerBtn;

@end



@implementation LDMyMessageHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.headBackIamge];
        [self addSubview:self.loginBtn];
        [self addSubview:self.registerBtn];
        
    }
    return self;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.textColor=[UIColor whiteColor];
        _loginBtn.titleLabel.font=[UIFont systemFontOfSize:18.0];
        
    }
    return _loginBtn;
}
-(UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.titleLabel.textColor=[UIColor whiteColor];
        _registerBtn.titleLabel.font=[UIFont systemFontOfSize:18.0];
        [_registerBtn addTarget:self action:@selector(pushRegisterViewController) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registerBtn;
}

-(void)pushRegisterViewController{
    
    if (_block) {
        _block();
    }
    
}
-(UIImageView *)headBackIamge{
    
    if (!_headBackIamge) {
        _headBackIamge=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我的背景"]];
        
    }
    return _headBackIamge;
}

#pragma mark -LayoutSubviews设置frame-

-(void)layoutSubviews{
    
    [super layoutSubviews];
 

    [_headBackIamge mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self);
        //make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 40, 0));

    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 23));
        make.centerX.equalTo(self.mas_centerX).offset(60);
        make.centerY.equalTo(self.mas_centerY);
      
    }];
    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 23));
        make.centerX.equalTo(self.mas_centerX).offset(-60);
        make.centerY.equalTo(self.mas_centerY);
       
    }];
    
      
    
}


@end
