//
//  LDLoginView.m
//  团购项目
//
//  Created by Ringo on 2016/11/18.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDLoginView.h"


NSString * const KEY_USERNAME_PASSWORD = @"com.company.app.usernamepassword";
NSString * const KEY_USERNAME = @"com.company.app.username";
NSString * const KEY_PASSWORD = @"com.company.app.password";



@interface LDLoginView ()<UITextFieldDelegate,BEMCheckBoxDelegate>

@property(strong,nonatomic)UIButton *loginBtn,*forgetBtn;
@property(nonatomic,strong)UILabel *textBackLabel,*midTextLineLabel,*remPassLabel;//textfield背景，textfield中间那条线
@property(nonatomic,strong)UIImageView *userNameImg,*passwordImg;
@property(strong,nonatomic)UIButton *visiblePWBtn;
@property(strong,nonatomic)BEMCheckBox *checkBox;
@end

@implementation LDLoginView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       //self.backgroundColor=[UIColor grayColor];
       
        [self addSubview:self.textBackLabel];//textField背景
        [self addSubview:self.passwordText];//密码框
        [self addSubview:self.phoneNumText];//手机号
        [self addSubview:self.midTextLineLabel];//中间线
        [self addSubview:self.loginBtn];//登录按钮
        [self addSubview:self.passwordImg];
        [self addSubview:self.userNameImg];
        [self addSubview:self.visiblePWBtn];
        [self addSubview:self.checkBox];
        [self addSubview:self.remPassLabel];
        [self addSubview:self.forgetBtn];
        
        [self loadUserInfo];//加载退出之前用户名和密码是否记住？
 
    }
    return self;
}


-(UIButton *)forgetBtn{
    if (!_forgetBtn) {
        _forgetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:RGBCOLOR(56, 166, 243) forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    }
    return _forgetBtn;
    
}

-(UILabel *)remPassLabel{
    if (!_remPassLabel) {
        _remPassLabel=[[UILabel alloc]init];
        _remPassLabel.text=@"记住密码";
        _remPassLabel.font=[UIFont systemFontOfSize:14];
        _remPassLabel.textColor=RGBCOLOR(56, 166, 243);
    }
    return _remPassLabel;
}

-(BEMCheckBox *)checkBox{

    
    if (!_checkBox) {
        _checkBox=[[BEMCheckBox alloc]init];
        _checkBox.boxType=BEMBoxTypeSquare;//设置○形状
        _checkBox.onAnimationType=BEMAnimationTypeFill;
        _checkBox.offAnimationType=BEMAnimationTypeFill;
        _checkBox.onTintColor=RGBCOLOR(188, 188, 188);//边缘颜色
        _checkBox.onCheckColor=[UIColor redColor];//✔颜色
        _checkBox.delegate=self;
    }
    return _checkBox;
}


//敲击复选框时的代理方法
-(void)didTapCheckBox:(BEMCheckBox *)checkBox{
    if (checkBox.on) {
        NSLog(@"********保存用户信息了*******");

    }
    
}
-(UIButton *)visiblePWBtn{
    
    if (!_visiblePWBtn) {
        _visiblePWBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_visiblePWBtn setImage:[UIImage imageNamed:@"login_noselect_eye2"] forState:UIControlStateNormal];
        [_visiblePWBtn setImage:[UIImage imageNamed:@"login_select_eye2"] forState:UIControlStateSelected];
        [_visiblePWBtn addTarget:self action:@selector(visiblePWBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _visiblePWBtn;
}




-(UIImageView *)passwordImg{
    if (!_passwordImg) {
        _passwordImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uctextfield_leftimage_passw"]];
    }
    return _passwordImg;
}

-(UIImageView *)userNameImg{
    if (!_userNameImg) {
        _userNameImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"uctextfield_leftimage_icon"]];
    }
    return _userNameImg;
}

-(UILabel *)midTextLineLabel{
    if (!_midTextLineLabel) {
        _midTextLineLabel=[[UILabel alloc]init];
        _midTextLineLabel.backgroundColor=RGBCOLOR(188, 188, 188);
    }
    return _midTextLineLabel;
    
}

-(UILabel *)textBackLabel{
    if (!_textBackLabel) {
        _textBackLabel=[[UILabel alloc]init];
        _textBackLabel.backgroundColor=[UIColor whiteColor];
        _textBackLabel.layer.borderWidth=1;//设置边缘宽度1
        _textBackLabel.layer.borderColor=RGBCOLOR(188, 188, 188).CGColor;//设置边缘颜色
    }
    return _textBackLabel;
}

-(UITextField *)phoneNumText{
    if (!_phoneNumText) {
        _phoneNumText=[[UITextField alloc]init];
        _phoneNumText.placeholder=@"请输入账号";
        _phoneNumText.keyboardType=UIKeyboardTypeNumberPad;//设置数字键盘
        _phoneNumText.font=[UIFont systemFontOfSize:16];
        _phoneNumText.clearButtonMode=UITextFieldViewModeWhileEditing;
       _phoneNumText.delegate=self;
    }
    return _phoneNumText;
    
}

-(UITextField *)passwordText{
    if (!_passwordText) {
        _passwordText=[[UITextField alloc]init];
        _passwordText.placeholder=@"请输入密码";
        _passwordText.clearButtonMode=UITextFieldViewModeWhileEditing;//编辑时，有删除按钮出现
        _passwordText.font=[UIFont systemFontOfSize:16];
        _passwordText.secureTextEntry=YES;
        _passwordText.delegate=self;
    }
    return _passwordText;
    
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius=5;
        _loginBtn.backgroundColor=RGBCOLOR(242, 131, 48);
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _loginBtn;
    
}

-(void)loginAction{
    if ([self.phoneNumText.text isEqualToString:@""]) {
        [self makeToast:@"请输入用户名" duration:1.5 position: @"CSToastPositionCenter"];
    }else if ([self.passwordText.text isEqualToString:@""]){
        [self makeToast:@"请输入密码" duration:1.5 position: @"CSToastPositionCenter"];
    }else {
       [self makeToast:@"登录成功" duration:1.5 position:  @"CSToastPositionCenter"];
       [self saveUserInfo];
}
}


-(void)saveUserInfo{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.checkBox.on forKey:@"checkboxStatus"];
    [defaults synchronize];//不要忘记这行代码

    
    if (self.checkBox.on) {
        
            //存用户名和密码到keychain
            NSMutableDictionary *mutableDict=[NSMutableDictionary dictionary];
            [mutableDict setObject:self.phoneNumText.text forKey:KEY_USERNAME];
            [mutableDict setObject:self.passwordText.text  forKey:KEY_PASSWORD];

            [LDDKeyChain save:KEY_USERNAME_PASSWORD data:mutableDict];
        
           NSLog(@"字典里所存内容为:%@",mutableDict);
        
    }
}

-(void)loadUserInfo{
    
    //调用之前checkbox按钮状态
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.checkBox.on = [defaults boolForKey:@"checkboxStatus"];

    // 从keychain中读取用户名和密码
    NSMutableDictionary* readDict = (NSMutableDictionary *)[LDDKeyChain load:KEY_USERNAME_PASSWORD];
    NSString *userName = [readDict objectForKey:KEY_USERNAME];
    NSString *password = [readDict objectForKey:KEY_PASSWORD];
    self.phoneNumText.text=userName;
    self.passwordText.text=password;
    
    }

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.textBackLabel.mas_bottom).offset(15);
    }];
    
    [_remPassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(60, 15));
         make.left.equalTo(self.mas_left).offset(35);
        make.top.equalTo(self.textBackLabel.mas_bottom).offset(15);

    }];
    
    [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(75, 15));
        make.top.equalTo(self.textBackLabel.mas_bottom).offset(15);
        
    }];
    
    [_userNameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 20));
        make.top.equalTo(self.phoneNumText.mas_top).offset(12);
    }];
    
    [_passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 20));
        make.top.equalTo(self.passwordText.mas_top).offset(12);
    }];
    

    [_phoneNumText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-50);;
        make.left.equalTo(self.mas_left).offset(35);
        make.height.equalTo(@44);
        make.top.equalTo(self.textBackLabel.mas_top);
        
    }];
    
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-50);
        make.left.equalTo(self.mas_left).offset(35);
        make.height.equalTo(@44);
        make.top.equalTo(self.phoneNumText.mas_bottom).offset(1);
        
    }];
    
    [_visiblePWBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(self.mas_right).offset(-20);
        make.centerY.equalTo(self.passwordText.mas_centerY);
        
    }];
    
    
    [_textBackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@89);
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.mas_left).offset(-1);
        make.right.equalTo(self.mas_right).offset(1);
        
    }];
    
    [_midTextLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(self.textBackLabel.mas_left).offset(15);
        make.right.equalTo(self.textBackLabel.mas_right).offset(0);
        make.centerY.equalTo(self.textBackLabel.mas_centerY);
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.equalTo(@35);
        make.top.equalTo(self.forgetBtn.mas_bottom).offset(15);
        
    }];
    
}

//明文和暗文密码的切换
-(void)visiblePWBtnAction:(UIButton*)button{
    
    //self.passwordText.enabled = NO;
    self.passwordText.secureTextEntry=button.selected;
    button.selected=!button.selected;
    //self.passwordText.enabled = YES;
    //[self.passwordText becomeFirstResponder];
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (range.length == 1 && string.length == 0) {
        return YES; //此句话十分重要，否则输满11个字符后，不能回退删除
    } else if (textField==self.phoneNumText ) { //用户名限制在11个字符
        return  textField.text.length<11 ;
    }
    
    
    if (textField == self.passwordText && textField.isSecureTextEntry) {
        NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        textField.text = toBeString;
        return NO;
    }
    
    return YES;
}


@end
