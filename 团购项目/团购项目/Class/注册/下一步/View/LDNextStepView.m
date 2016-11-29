//
//  LDNextStepView.m
//  团购项目
//
//  Created by Ringo on 2016/11/16.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDNextStepView.h"


@interface LDNextStepView ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *hintLabel,*backLabel;//提示标签和背景

@property(nonatomic,strong)UIButton *countdownBtn,*registerBtn;//倒计时按钮,注册按钮

@end

@implementation LDNextStepView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self  addSubview:self.hintLabel];
        [self  addSubview:self.backLabel];
        [self  addSubview:self.VerificationText];
        [self  addSubview:self.countdownBtn];
        [self  addSubview:self.registerBtn];
       
    }
    return self;
}

//创建计时器
-(void)countdownTime{
    
    __block NSInteger time =60;
    dispatch_queue_t  queue=dispatch_get_global_queue(0, 0);//创建线程
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (time<0) {
            dispatch_source_cancel(timer);//时间为0时，倒计时停止
            
            //主线程里更新UI,否则程序崩溃
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //倒计时为0时，修改btn上的文字为“重新发送”
                NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:@"重新发送" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(56, 166, 243)}];
                [self.countdownBtn setAttributedTitle:str forState:UIControlStateNormal];
                
                self.countdownBtn.userInteractionEnabled=YES;//倒计时结束结束，btn（重新发送）可以点击
            });
            
        }else{
            //主线程更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                self.countdownBtn.userInteractionEnabled=NO;//倒计时正在进行时，btn可不点击
                [self.countdownBtn setAttributedTitle:[self makeTimeCountdownAttribute:time] forState:UIControlStateNormal];
                 time--;
                
            });
            
        }
        
    });
    dispatch_resume(timer);
}

//设置提示标签上的文字
-(void)setPhoneNumberStr:(NSString *)phoneNumberStr{
    
    _phoneNumberStr=phoneNumberStr;
    NSMutableAttributedString *str1=[[NSMutableAttributedString alloc]initWithString:@"验证码短信已发送至" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(139, 139, 139)}];
    NSMutableAttributedString *str2=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",phoneNumberStr] attributes:@{NSForegroundColorAttributeName:RGBCOLOR(56, 166, 243)}];
    [str1 insertAttributedString:str2 atIndex:str1.length];//字符串拼接
    self.hintLabel.attributedText=str1;//提示标签赋值（电话号码）
    
//    //倒计时设置富文本
//    [self.countdownBtn setAttributedTitle:[self makeTimeCountdownAttribute:] forState:UIControlStateNormal];
    
}

-(NSMutableAttributedString*)makeTimeCountdownAttribute:(NSInteger)timer{
    
    NSMutableAttributedString *str1=[[NSMutableAttributedString alloc]initWithString:@"s后可重发" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(188, 188, 188)}];
    NSMutableAttributedString *str2=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",(long)timer] attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    [str2 insertAttributedString:str1 atIndex:str2.length];//字符串拼接
  
    return str2;
    
}


-(UILabel *)hintLabel{
    
    if (!_hintLabel) {
        _hintLabel=[[UILabel alloc]init];
        _hintLabel.font=[UIFont systemFontOfSize:12];
        _hintLabel.textColor=RGBCOLOR(80, 80, 80);
    }
    return _hintLabel;
}

-(UILabel *)backLabel{
    if (!_backLabel) {
        _backLabel=[[UILabel alloc]init];
        _backLabel.backgroundColor=[UIColor whiteColor];
        _backLabel.layer.borderWidth=1;
        _backLabel.layer.borderColor=RGBCOLOR(188, 188, 188).CGColor;
    }
    return _backLabel;
}

-(UITextField *)VerificationText{
    if (!_VerificationText) {
        _VerificationText=[[UITextField alloc]init];
        _VerificationText.placeholder=@"请输入6位验证码";
        _VerificationText.font=[UIFont systemFontOfSize:14];
        _VerificationText.clearButtonMode=UITextFieldViewModeWhileEditing;
        _VerificationText.delegate=self;
        [_VerificationText addTarget:self action:@selector(VerificationTextChangeText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _VerificationText;
    
}



-(UIButton *)countdownBtn{
    
    if (!_countdownBtn) {
        _countdownBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _countdownBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        _countdownBtn.layer.cornerRadius=3;
        //_countdownBtn.layer.borderWidth=1;
        //_countdownBtn.layer.borderColor=RGBCOLOR(188, 188, 188).CGColor;
        
        [_countdownBtn setBackgroundColor:RGBCOLOR(249, 249, 249)];
        [_countdownBtn addTarget:self action:@selector(countdownTime) forControlEvents:UIControlEventTouchUpInside];//添加计时器方法
        
    }
    return _countdownBtn;
    
}
-(UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.layer.cornerRadius=5;
        _registerBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        _registerBtn.backgroundColor=RGBCOLOR(242, 131, 48);
        [_registerBtn setTitleColor:RGBCOLOR(132, 132, 132) forState:UIControlStateNormal];
        _registerBtn.userInteractionEnabled=NO;
        [_registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registerBtn;
    
}

//block,传递验证码内容
-(void)registerAction{
    if (self.block) {
        self.block(self.VerificationText.text);
    }
    
}

//设置frame
-(void)layoutSubviews{
    
    [ _hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.left.equalTo(self.backLabel.mas_left).offset(15);
        make.height.equalTo(@35);
    }];
    
    
    [_VerificationText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.bottom.equalTo(self.backLabel);
        make.right.equalTo(self.countdownBtn.mas_left).offset(50);
    }];
    
    [_backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.top.equalTo(self.hintLabel.mas_bottom);
        make.left.equalTo(self.mas_left).offset(-1);
        make.right.equalTo(self.mas_right).offset(1);
    }];
    
    
    [_countdownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 30));
        make.top.equalTo(self.backLabel).offset(7);
        make.right.equalTo(self.backLabel).offset(-15);
    }];
    
    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backLabel.mas_bottom).offset(40);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.equalTo(@35);
        
    }];
    
}


//输入字符数，改变button上的文字颜色和button是否可点击
-(void)VerificationTextChangeText:(UITextField*)textField{
    
    if (textField.text.length==6) {
        self.registerBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.registerBtn.userInteractionEnabled=YES;
    }else{
        self.registerBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [self.registerBtn setTitleColor:RGBCOLOR(132, 132, 132) forState:UIControlStateNormal];
        self.registerBtn.userInteractionEnabled=NO;
    }
    
    
}


//代理，限制输入字符数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (range.length == 1 && string.length == 0) {
        return YES;
    } else if (textField==self.VerificationText ) { //用户名限制在6个字符
        return textField.text.length < 6;
    }
    return YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.VerificationText resignFirstResponder];
}


@end
