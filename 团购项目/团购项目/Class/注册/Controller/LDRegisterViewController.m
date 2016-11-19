//
//  LDRegisterViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/15.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDRegisterViewController.h"
#import "LDThirdLoginview.h"
#import "LDRegisterView.h"

#import "LDNextViewController.h" //注册跳转下一步

@interface LDRegisterViewController ()
@property(nonatomic,strong)LDRegisterView *registerView;
@end

@implementation LDRegisterViewController


//navigationcontroller 下一层返回到本页时，需要清空之前输入
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.registerView.passwordText.text=@"";
    self.registerView.phoneNumText.text=@"";
    [self.registerView.phoneNumText resignFirstResponder];
    [self.registerView.passwordText resignFirstResponder];
    
}
-(LDRegisterView *)registerView{
    if (!_registerView) {
        _registerView=[[LDRegisterView alloc]init];
        
        //block
        __weak typeof(self) weakself=self;
        _registerView.block=^(NSDictionary *dict){
            
            LDNextViewController *nextVC=[[LDNextViewController alloc]init];//“下一步”视图控制器

            nextVC.userMessageDic=dict;//下一步试图控制器的userMessageDic用于接受密码和手机号
            
            [weakself.navigationController pushViewController:nextVC animated:YES];
            
        };
        
    }
    return _registerView;
}



- (void)viewDidLoad {
    self.title=@"注册1/2";
    self.view.backgroundColor=[UIColor whiteColor];
    //self.extendedLayoutIncludesOpaqueBars=0;
    [super viewDidLoad];
    [self.view addSubview:self.registerView];
    [self setupConstraints];
   // self.registerView.backgroundColor=[UIColor grayColor];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)setupConstraints{
    
   [ _registerView mas_makeConstraints:^(MASConstraintMaker *make) {
      
       make.left.bottom.right.equalTo(self.view);
       make.top.equalTo(self.view.mas_top).offset(64);
 
   }];
    
    
    
}


@end
