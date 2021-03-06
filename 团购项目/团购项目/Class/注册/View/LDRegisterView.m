//
//  LDRegisterView.m
//  团购项目
//
//  Created by Ringo on 2016/11/15.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDRegisterView.h"

@interface LDRegisterView ()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *hintLabel,*textBackLabel,*midTextLineLabel;//提示标签,textfield背景，textfield中间那条线
@property(nonatomic,strong)UIImageView *userNameImg,*passwordImg,*logoImage;

@end


@implementation LDRegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.hintLabel];//提示标签
        [self addSubview:self.textBackLabel];//textField背景
        [self addSubview:self.passwordText];//密码框
        [self addSubview:self.phoneNumText];//手机号
        [self addSubview:self.midTextLineLabel];//中间线
        [self addSubview:self.nextStepBtn];//下一步按钮
       
        [self addSubview:self.passwordImg];
        [self addSubview:self.userNameImg];
        [self addSubview:self.logoImage];
       // self.backgroundColor=[UIColor grayColor];
    }
    return self;
}

-(UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo_1"]];
        
    }
    return _logoImage;
}
-(UIImageView *)passwordImg{
    if (!_passwordImg) {
        _passwordImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Login_password"]];
    }
    return _passwordImg;
}

-(UIImageView *)userNameImg{
    if (!_userNameImg) {
        _userNameImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Register_cell"]];
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


-(UILabel *)hintLabel{
    if (!_hintLabel) {
        _hintLabel=[[UILabel alloc]init];
        _hintLabel.text=@"请输入手机号码，注册新用户";
        _hintLabel.font=[UIFont systemFontOfSize:15];
        _hintLabel.textColor=RGBCOLOR(80, 80, 80);
    }
    return _hintLabel;
    
}


-(UITextField *)phoneNumText{
    if (!_phoneNumText) {
        _phoneNumText=[[UITextField alloc]init];
        _phoneNumText.placeholder=@"请输入手机号码";
        _phoneNumText.keyboardType=UIKeyboardTypeNumberPad;//设置数字键盘
        _phoneNumText.font=[UIFont systemFontOfSize:16];
        _phoneNumText.clearButtonMode=UITextFieldViewModeWhileEditing;
        [_phoneNumText addTarget:self action:@selector(phoneNumTextChangeText:) forControlEvents:UIControlEventEditingChanged];
        _phoneNumText.delegate=self;
    }
    return _phoneNumText;
    
}

-(UITextField *)passwordText{
    if (!_passwordText) {
        _passwordText=[[UITextField alloc]init];
        _passwordText.placeholder=@"请设置账户密码";
        _passwordText.clearButtonMode=UITextFieldViewModeWhileEditing;//编辑时，有删除按钮出现
        _passwordText.font=[UIFont systemFontOfSize:16];
        _passwordText.secureTextEntry=YES;
        
        [_passwordText addTarget:self action:@selector(passwordTextChangeText:) forControlEvents:UIControlEventEditingChanged];

        _passwordText.delegate=self;
    }
    return _passwordText;
    
}

-(UIButton *)nextStepBtn{
    if (!_nextStepBtn) {
        _nextStepBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStepBtn setTitle:@"下一步，验证手机号" forState:UIControlStateNormal];
        _nextStepBtn.layer.cornerRadius=5;
        
        _nextStepBtn.backgroundColor=RGBCOLOR(242, 131, 48);
        [_nextStepBtn setTitleColor:RGBCOLOR(132, 132, 132) forState:UIControlStateNormal];
        _nextStepBtn.userInteractionEnabled=NO;
        [_nextStepBtn addTarget:self action:@selector(pushNextViewController) forControlEvents:UIControlEventTouchUpInside];
    
    
    }
    return _nextStepBtn;
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_userNameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(25, 20));
        make.top.equalTo(self.phoneNumText.mas_top).offset(12);
    }];
    
 

    
    [_passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(25, 20));
        make.top.equalTo(self.passwordText.mas_top).offset(12);
    }];
    
    
    [ _logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(-70);
        make.left.equalTo(self.mas_left).offset(70);
        make.height.mas_equalTo( 50);
    }];
    
    
    [_phoneNumText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left).offset(40);
        make.height.equalTo(@44);
        make.top.equalTo(self.textBackLabel.mas_top);
        
    }];
    
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self.mas_left).offset(40);
        make.height.equalTo(@44);
        make.top.equalTo(self.phoneNumText.mas_bottom).offset(1);
        
    }];
    

    
       [_textBackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@89);
        make.top.equalTo(self.logoImage.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(-1);
        make.right.equalTo(self.mas_right).offset(1);
        
    }];
    
    [_midTextLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(self.userNameImg.mas_left);
        make.right.equalTo(self.textBackLabel.mas_right).offset(-15);
        make.centerY.equalTo(self.textBackLabel.mas_centerY);
    }];
    
      [_nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.equalTo(@35);
        make.top.equalTo(self.passwordText.mas_bottom).offset(40);
        
    }];
    
}


#pragma mark -text change,修改内容时调用-

-(void)phoneNumTextChangeText:(UITextField*)textField{
    
    if (textField.text.length==11&&self.passwordText.text.length>5) {
         self.nextStepBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];//字体加粗
         [self.nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         self.nextStepBtn.userInteractionEnabled=YES;
    }else{
         self.nextStepBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [self.nextStepBtn setTitleColor:RGBCOLOR(132, 132, 132) forState:UIControlStateNormal];
         self.nextStepBtn.userInteractionEnabled=NO;
    }
    
}

-(void)passwordTextChangeText:(UITextField*)textField{
    
    if (textField.text.length>5 &&self.phoneNumText.text.length==11) {
       self.nextStepBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [self.nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.nextStepBtn.userInteractionEnabled=YES;

    }else{
        self.nextStepBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [self.nextStepBtn setTitleColor:RGBCOLOR(132, 132, 132) forState:UIControlStateNormal];
        self.nextStepBtn.userInteractionEnabled=NO;
    }

    
}

#pragma mark- 限制用户名位数-
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (range.length == 1 && string.length == 0) {
        return YES; //此句话十分重要，否则输满11个字符后，不能回退删除
    } else if (textField==self.phoneNumText ) { //用户名限制在11个字符
        return  textField.text.length<11 ;
    }
       return YES;
}


#pragma mark-pushNextViewController-
-(void)pushNextViewController{
    
  if (self.block) { //将手机号和密码一起传给控制器
        
        self.block(@{@"phoneName": self.phoneNumText.text,@"password":self.passwordText.text});
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.phoneNumText resignFirstResponder];
    [self.passwordText resignFirstResponder];
}


@end
