//
//  LDThirdLoginview.m
//  团购项目
//
//  Created by Ringo on 2016/11/15.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDThirdLoginview.h"

@interface LDThirdLoginview ()
@property(nonatomic,strong)UILabel *oneKeyLogin,*lineLabel,*qqLabel,*wechatLabel,*weiboLabel;;
@property(strong,nonatomic)UIButton *qqBtn,*weChatBtn,*sinaBtn;

@end

@implementation LDThirdLoginview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.lineLabel];//先添加线，再添加一键登录按钮
        [self  addSubview:self.oneKeyLogin];
        [self  addSubview:self.qqBtn];
        [self  addSubview:self.weChatBtn];
        [self  addSubview:self.sinaBtn];
        [self addSubview:self.qqLabel];
        [self addSubview:self.weiboLabel];
        [self addSubview:self.wechatLabel];
    }
    return self;
}



-(UILabel *)qqLabel{
    if (!_qqLabel) {
        _qqLabel=[[UILabel alloc]init];
        _qqLabel.text=@"QQ登录";
        _qqLabel.textColor=RGBCOLOR(190, 190, 190);
        _qqLabel.font=[UIFont systemFontOfSize:12];
        _qqLabel.textAlignment=UITextAlignmentCenter;
    }
    return _qqLabel;

}


-(UILabel *)wechatLabel{
    if (!_wechatLabel) {
        _wechatLabel=[[UILabel alloc]init];
        _wechatLabel.textColor=RGBCOLOR(190, 190, 190);
        _wechatLabel.text=@"微信登录";
        _wechatLabel.font=[UIFont systemFontOfSize:12];
        _wechatLabel.textAlignment=UITextAlignmentCenter;
    }
    return _wechatLabel;
    
}


-(UILabel *)weiboLabel{
    
    if (!_weiboLabel) {
        _weiboLabel=[[UILabel alloc]init];
        _weiboLabel.textColor=RGBCOLOR(190, 190, 190);
        _weiboLabel.text=@"微博登录";
        _weiboLabel.font=[UIFont systemFontOfSize:12];
        _weiboLabel.textAlignment=UITextAlignmentCenter;
    }
    return _weiboLabel;
    
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel=[[UILabel alloc]init];
        _lineLabel.backgroundColor=RGBCOLOR(190, 190, 190);
    }
    return _lineLabel;
}

-(UILabel *)oneKeyLogin{
    if (!_oneKeyLogin) {
        _oneKeyLogin=[[UILabel alloc]init];
        _oneKeyLogin.text=@"第三方账号快速登录";
        _oneKeyLogin.textColor=RGBCOLOR(190, 190, 190) ;
        _oneKeyLogin.backgroundColor=[UIColor whiteColor];//设置按钮的背景矩形区域，背景和view背景相同
        _oneKeyLogin.textAlignment=UITextAlignmentCenter;
        _oneKeyLogin.font=[UIFont systemFontOfSize:14];
    }
    return _oneKeyLogin;
    
}


-(UIButton *)qqBtn{
    
    if (!_qqBtn) {
        _qqBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_qqBtn setImage:[UIImage imageNamed:@"registerAndLogin_qq_button"] forState:UIControlStateNormal];
         [_qqBtn setImage:[UIImage imageNamed:@"registerAndLogin_qq_button"] forState:UIControlStateSelected];
    }
    return _qqBtn;
}

-(UIButton *)weChatBtn{
    
    if (!_weChatBtn) {
        _weChatBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_weChatBtn setImage:[UIImage imageNamed:@"registerAndLogin_wechat_button"] forState:UIControlStateNormal];
        [_weChatBtn setImage:[UIImage imageNamed:@"registerAndLogin_wechat_button"] forState:UIControlStateSelected];
    }
    return _weChatBtn;
}

-(UIButton *)sinaBtn{
    
    if (!_sinaBtn) {
        _sinaBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sinaBtn setImage:[UIImage imageNamed:@"registerAndLogin_weibo_button"] forState:UIControlStateNormal];
        [_sinaBtn setImage:[UIImage imageNamed:@"registerAndLogin_weibo_button"] forState:UIControlStateSelected];

    }
    return _sinaBtn;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_oneKeyLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(150, 20));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        
    }];
    
    [_weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.equalTo(self.oneKeyLogin.mas_bottom).offset(40);
        make.centerX.equalTo(self.mas_centerX);
        
    }];
    
    
    [_wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 16));
        make.top.equalTo(self.weChatBtn.mas_bottom).offset(2);
        make.centerX.equalTo(self.mas_centerX);

    }];
    
    [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.equalTo(self.oneKeyLogin.mas_bottom).offset(40);
        make.right.equalTo(self.weChatBtn.mas_left).offset(-(self.frame.size.width-150)/4);
        
    }];
    [_qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 16));
        make.top.equalTo(self.qqBtn.mas_bottom).offset(2);
        make.right.equalTo(self.wechatLabel.mas_left).offset(-(self.frame.size.width-150)/4);
    
    }];
    
    [_sinaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.equalTo(self.oneKeyLogin.mas_bottom).offset(40);
        make.left.equalTo(self.weChatBtn.mas_right).offset((self.frame.size.width-150)/4);
    }];
    
    
    [_weiboLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 16));
        make.top.equalTo(self.sinaBtn.mas_bottom).offset(2);
        make.left.equalTo(self.wechatLabel.mas_right).offset((self.frame.size.width-150)/4);

    }];
    
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.oneKeyLogin.mas_centerY);
        make.height.equalTo(@1);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        
    }];

    
    
}
@end
