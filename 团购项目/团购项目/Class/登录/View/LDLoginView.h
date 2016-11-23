//
//  LDLoginView.h
//  团购项目
//
//  Created by Ringo on 2016/11/18.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^LoginBlock)(NSDictionary *dict);
@interface LDLoginView : UIView

@property(copy,nonatomic)LoginBlock  loginblock;
@property(strong,nonatomic)UITextField *phoneNumText, *passwordText;

@property(strong,nonatomic)UIButton *registerBtn,*loginBtn;;
@property(strong,nonatomic)BEMCheckBox *checkBox;

@end
