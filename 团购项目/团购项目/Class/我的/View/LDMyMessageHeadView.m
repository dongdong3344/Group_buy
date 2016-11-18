//
//  LDMyMessageHeadView.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDMyMessageHeadView.h"

@interface LDMyMessageHeadView()

@property(nonatomic,strong)UIImageView *headBackIamge,*portraitView;
@property(nonatomic,strong)UIButton *loginBtn, *registerBtn;

@end



@implementation LDMyMessageHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.headBackIamge];
        //[self addSubview:self.loginBtn];
        [self addSubview:self.registerBtn];
        [self addSubview:self.portraitView];
        
    }
    return self;
}


-(UIImageView *)portraitView{
    
    if (!_portraitView) {
        _portraitView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lr_avatar"]];
    }
    return _portraitView;
}
-(UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_registerBtn setBackgroundImage:[UIImage imageNamed:@"myctrip_btn_login"] forState:UIControlStateNormal];
        [_registerBtn setBackgroundImage:[UIImage imageNamed:@"myctrip_btn_login_pressed"] forState:UIControlStateSelected];
        _registerBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
        
               _registerBtn.layer.cornerRadius=5;
//        _registerBtn.layer.borderWidth=1;
//        _registerBtn.layer.borderColor=[UIColor whiteColor].CGColor;
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
        _headBackIamge=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register_back"]];
        
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
    
    
    [_portraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headBackIamge.mas_centerX);
        make.centerY.equalTo(self.headBackIamge.mas_centerY).offset(-15);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        
    }];

    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.portraitView.mas_bottom).offset(5);
    
    }];
    
    
    
}


@end
