//
//  LDLoginViewController.h
//  团购项目
//
//  Created by Ringo on 2016/11/18.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDBaseViewController.h"
#import "LDLoginView.h"



@interface LDLoginViewController :LDBaseViewController
@property(strong,nonatomic)LDLoginView *loginView;
@property(strong,nonatomic)NSUserDefaults *phoneNumDefaultes;
@end
