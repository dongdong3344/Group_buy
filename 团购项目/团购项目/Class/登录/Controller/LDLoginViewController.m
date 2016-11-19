//
//  LDLoginViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/18.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDLoginViewController.h"
#import "LDRegisterViewController.h"
#import "LDThirdLoginview.h"
#import "LDLoginView.h"
@interface LDLoginViewController ()
@property(strong,nonatomic)LDLoginView *loginView;
@property(strong,nonatomic)LDThirdLoginview *thirdLoginView;
@end

@implementation LDLoginViewController


-(LDLoginView *)loginView{
    
    if (!_loginView) {
        _loginView=[[LDLoginView alloc]init];
    }
    return _loginView;
}

-(LDThirdLoginview *)thirdLoginView{
    if (!_thirdLoginView) {
        _thirdLoginView=[[LDThirdLoginview alloc]init];
    }
    return _thirdLoginView;
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"用户登录";
    [self setupRightItem];
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.thirdLoginView];
   // self.extendedLayoutIncludesOpaqueBars=0;

    [self setupConstraints];
         }
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(void)setupRightItem{
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(nextViewController)];
    [rightItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
     [rightItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem=rightItem;
    
}
-(void)nextViewController{
    LDRegisterViewController *regVC=[[LDRegisterViewController alloc]init];
    [self.navigationController pushViewController:regVC animated:YES];
    
}



-(void)setupConstraints{
    
    [self.loginView  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(60);
        make.height.equalTo(@200);
        
    }];
    
    
    [self.thirdLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@180);
       
        
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self.loginView.phoneNumText resignFirstResponder];
    
    [self.loginView.passwordText resignFirstResponder];
}

@end
