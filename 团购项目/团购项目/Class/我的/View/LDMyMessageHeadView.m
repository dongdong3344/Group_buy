//
//  LDMyMessageHeadView.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDMyMessageHeadView.h"

@interface LDMyMessageHeadView()

@property(nonatomic,strong)UIImageView *headBackIamge,*portraitView,*loginPortraitView;//图片背景，头像,登录后的头像
@property(nonatomic,strong)UIButton *registerBtn;//登录注册

@end



@implementation LDMyMessageHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headBackIamge];
        [self addSubview:self.registerBtn];
        [self addSubview:self.portraitView];
        [self addSubview:self.loginPortraitView];
        [self addSubview:self.welcomeLabel];

        
    }
    return self;
}




-(UILabel *)welcomeLabel{
    
    if (!_welcomeLabel) {
        _welcomeLabel=[[UILabel alloc]init];
        //_welcomeLabel.text=@"欢迎您,15262352648";
        _welcomeLabel.font=[UIFont boldSystemFontOfSize:14];
        _welcomeLabel.textColor=[UIColor whiteColor];
        _welcomeLabel.textAlignment= kCTTextAlignmentCenter ;

      
    }
    return _welcomeLabel;
}
-(UIImageView *)loginPortraitView{
    if (!_loginPortraitView) {
        _loginPortraitView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"headImage"]];
        _loginPortraitView.layer.cornerRadius=40;
        _loginPortraitView.layer.masksToBounds=YES;
        _loginPortraitView.layer.borderWidth=2;
       // _loginPortraitView.contentMode=UIViewContentModeScaleAspectFit;//设置图片不变形
        _loginPortraitView.layer.borderColor=RGBCOLOR(242, 242, 242).CGColor;
    }
    return _loginPortraitView;
    
}
-(UIImageView *)portraitView{
    
    if (!_portraitView) {
        _portraitView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"defautImage"]];
        
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
        [_registerBtn addTarget:self action:@selector(pushRegisterViewController) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registerBtn;
}


-(UIImageView *)headBackIamge{
    
    if (!_headBackIamge) {
        _headBackIamge=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"register_back2"]];
        
    }
    return _headBackIamge;
}

//重新加载headview
- (void)reloadHeadView{
    NSDictionary *loginDic = [[NSUserDefaults standardUserDefaults]valueForKey:@"ISLOGIN"];
    if (loginDic.count){
        self.registerBtn.hidden = YES;//隐藏登录注册按钮
        self.portraitView.hidden=YES;
        self.loginPortraitView.hidden=NO;
        self.welcomeLabel.hidden=NO;
       
    }else{
       self.registerBtn.hidden = NO;
        self.portraitView.hidden=NO;
        self.loginPortraitView.hidden=YES;
        self.welcomeLabel.hidden=YES;

    }
    
}

//block
-(void)pushRegisterViewController{
    
    if (_block) {
        _block();
    }
    
}



#pragma mark -LayoutSubviews设置frame-

-(void)layoutSubviews{
    
    [super layoutSubviews];
 

    [_headBackIamge mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self);
       
    }];
    
    
    [_portraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headBackIamge.mas_centerX);
        make.centerY.equalTo(self.headBackIamge.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        
    }];
    
    
    [_loginPortraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headBackIamge.mas_centerX);
        make.centerY.equalTo(self.headBackIamge.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        
    }];
    
    
    [_welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginPortraitView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 15));
        //make.left.mas_equalTo(50);
         make.centerX.equalTo(self.loginPortraitView.mas_centerX);
    }];
    

    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.portraitView.mas_bottom).offset(10);
    
    }];
    
    
    
}


@end
