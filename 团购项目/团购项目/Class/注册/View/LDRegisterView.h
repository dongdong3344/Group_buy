//
//  LDRegisterView.h
//  团购项目
//
//  Created by Ringo on 2016/11/15.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RegisterViewBlock)(NSDictionary *dict) ;//传递手机号和密码

@interface LDRegisterView : UIView
@property(strong,nonatomic)UITextField *phoneNumText, *passwordText;

@property(nonatomic,copy)RegisterViewBlock block;

@end
