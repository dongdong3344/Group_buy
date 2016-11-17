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
@property(nonatomic,strong)LDThirdLoginview *thirdLoginview;

@end

@implementation LDRegisterViewController

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

-(LDThirdLoginview *)thirdLoginview{
    if (!_thirdLoginview) {
        _thirdLoginview=[[LDThirdLoginview alloc]init];
    }
    return _thirdLoginview;
}

- (void)viewDidLoad {
    self.title=@"注册";
    self.view.backgroundColor=[UIColor whiteColor];
    self.extendedLayoutIncludesOpaqueBars=0;
    [super viewDidLoad];
    [self.view addSubview:self.registerView];
    [self.view addSubview:self.thirdLoginview];
    [self setupConstraints];
    
}

-(void)setupConstraints{
    
   [ _registerView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.height.equalTo(@340);
       make.left.right.top.equalTo(self.view);
 
   }];
    
    
    [_thirdLoginview mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.equalTo(self.registerView.mas_bottom).offset(80);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@85);
    }];
    
}


@end
