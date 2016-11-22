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
#import "LDNextViewController.h"



NSString * const KEY_USERNAME_PASSWORD = @"com.company.app.usernamepassword";
NSString * const KEY_USERNAME = @"com.company.app.username";
NSString * const KEY_PASSWORD = @"com.company.app.password";


@interface LDLoginViewController ()

@property(strong,nonatomic)LDThirdLoginview *thirdLoginView;

@property(strong,nonatomic)NSDictionary *userInfoDic;
@end

@implementation LDLoginViewController


//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.loginView.passwordText.text=@"";
//    self.loginView.phoneNumText.text=@"";
//    [self.loginView.passwordText resignFirstResponder];
//    [self.loginView.phoneNumText resignFirstResponder];
//}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
 
   
}

-(LDLoginView *)loginView{
    
    if (!_loginView) {
        _loginView=[[LDLoginView alloc]init];
        
        [self.loginView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginView;
}


-(void)loginAction{
    
    //登录名:LoginName
    //密码：Lpassword
     //http://123.57.141.249:8080/beautalk/appMember/appLogin.do
    /*
     @"CSToastPositionTop";
     @"CSToastPositionCenter";
     @"CSToastPositionBottom";
     
     */
    
    
    [self.loginView.passwordText resignFirstResponder];
    [self.loginView.phoneNumText resignFirstResponder];
    if ([self.loginView.phoneNumText.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入用户名" duration:1.5 position:  @"CSToastPositionCenter"];
        
    }else if ([self.loginView.passwordText.text isEqualToString:@""]){
        [self.view makeToast:@"请输入密码" duration:1.5 position:  @"CSToastPositionCenter"];
    }else{
        
        [self getWithURLString:@"appMember/appLogin.do" parameters:@{@"LoginName":self.loginView.phoneNumText.text,@"Lpassword":self.loginView.passwordText.text} success:^(id responseObject) {
              [NSThread sleepForTimeInterval:1.5];//1.5秒后执行显示信息，小圆圈先转1秒
          LDDLog(@"responseObject : %@",responseObject);
        if ([responseObject[@"ErrorMessage"] isEqualToString:@"登陆成功"]) {
            [self saveUserInfo];//保存用户名和密码信息
                [self showTostMessage:@"登录成功"];
            //存储登录状态
            [[NSUserDefaults standardUserDefaults ]setObject:responseObject forKey:@"ISLOGIN"];
            [self performSelector:@selector(popToMineViewController) withObject:nil afterDelay:1];//1秒后跳转我的界面
        }else if ([responseObject[@"ErrorMessage"] isEqualToString:@"密码错误"]){
            [self showTostMessage:@"用户名或密码错误，请核实后重新输入"];

        }else if ([responseObject[@"ErrorMessage"] isEqualToString:@"用户名或密码错误，请重新输入"]){
            [self showTostMessage:@"用户名或密码错误，请核实后重新输入"];

        }else{
            [self showTostMessage:@"登录失败"];
        }

            
        } failure:^(NSError *error) {
            LDDLog(@"error : %@",error);

        }];

    }
}
-(void)popToMineViewController{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)saveUserInfo{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.loginView.checkBox.on forKey:@"checkboxStatus"];
    [defaults synchronize];//不要忘记这行代码
    
   // NSLog(@"**********checkbox的状态为：%d",self.loginView.checkBox.on);
    
    
    NSMutableDictionary *mutableDict=[NSMutableDictionary dictionary];
    [mutableDict setObject:self.loginView.phoneNumText.text forKey:KEY_USERNAME];
     [LDDKeyChain save:KEY_USERNAME data:mutableDict];
    
       if (self.loginView.checkBox.on) {
        //存用户名和密码到keychain
           
        [mutableDict setObject:self.loginView.passwordText.text  forKey:KEY_PASSWORD];
        [LDDKeyChain save:KEY_PASSWORD data:mutableDict];
       // NSLog(@"字典里所存内容为:%@",mutableDict);
     
       }

    if (!self.loginView.checkBox.on) {
        [LDDKeyChain delete:KEY_PASSWORD];//删除密码，用户名还保留
    }


}

-(void)loadUserInfo{
    
    //调用之前checkbox按钮状态
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.loginView.checkBox.on = [defaults boolForKey:@"checkboxStatus"];
    
    // 从keychain中读取用户名和密码
    NSMutableDictionary* readDict = (NSMutableDictionary *)[LDDKeyChain load:KEY_USERNAME];
    NSMutableDictionary* readDict2 = (NSMutableDictionary *)[LDDKeyChain load:KEY_PASSWORD];
    NSString *userName = [readDict objectForKey:KEY_USERNAME];
    NSString *password = [readDict2 objectForKey:KEY_PASSWORD];
    self.loginView.phoneNumText.text=userName;
    self.loginView.passwordText.text=password;
    
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
    
   // self.edgesForExtendedLayout=0;

    [self setupRightItem];
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.thirdLoginView];
    [self setupConstraints];
    
    //[LDDKeyChain delete:KEY_USERNAME_PASSWORD];//删除用户名和密码信息
     [self loadUserInfo];//加载上次登录，是否保存了用户名和密码
    
    

}


-(void)setupRightItem{
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 35, 20);//不设置btn frame，无法显示出来
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"注册" forState:UIControlStateHighlighted];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(nextViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightItem;

}
-(void)nextViewController{
    LDRegisterViewController *regVC=[[LDRegisterViewController alloc]init];
    [self.navigationController pushViewController:regVC animated:YES];
    
}

-(void)setupConstraints{
    
    [self.loginView  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(59);
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


- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    
    
    return YES;
}
@end
