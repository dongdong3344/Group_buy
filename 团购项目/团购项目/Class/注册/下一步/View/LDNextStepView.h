//
//  LDNextStepView.h
//  团购项目
//
//  Created by Ringo on 2016/11/16.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^NextStepViewBlock)(NSString *code);

@interface LDNextStepView : UIView

@property(nonatomic,strong)NSString *phoneNumberStr;//手机号码字符串
@property(nonatomic,strong)UITextField *VerificationText;//验证码输入框
@property(copy,nonatomic)NextStepViewBlock block;

-(void)countdownTime;


@end
