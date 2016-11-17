//
//  LDNextViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/15.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDNextViewController.h"
#import "LDNextStepView.h"

@interface LDNextViewController ()
@property(strong,nonatomic)LDNextStepView *nextView;
@end

@implementation LDNextViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];//不设置颜色，页面切换时闪烁
    self.edgesForExtendedLayout=0;
    self.title=@"验证手机号";
    //LDDLog(@"用户名和密码是:%@",self.userMessageDic);
    
    [self.view addSubview:self.nextView];
    [self requestVerificationCode];//请求验证码
    [self setupConstraints];
  
}


-(LDNextStepView *)nextView{
    
    if (!_nextView) {
        _nextView=[[LDNextStepView alloc]init];
        _nextView.phoneNumberStr=self.userMessageDic[@"phoneName"];//电话号码值传递
        
        __weak typeof(self) weakself=self;
        _nextView.block=^(NSString *code){ //block拿到验证码内容
            
            [weakself registerMethod:code];
            
        };
        
    }
    return _nextView;
}


//请求验证码
//http://123.57.141.249:8080/beautalk/appMember/createCode.do
-(void)requestVerificationCode{
    
    [self postWithURLString:@"appMember/createCode.do" parameters:@{@"MemberId":self.userMessageDic[@"phoneName"]}
                 success:^(id responseObject) {
                     
                     LDDLog(@"%@",responseObject);
                     if ([responseObject[@"result"] isEqualToString:@"success"]) {
                         [self.nextView countdownTime];// //网络请求成功后，调用倒计时方法
                     }else if ([responseObject[@"result"] isEqualToString:@"TelephoneExistError"]){
                         //LDDLog(@"手机号已经被注册");
                         [self showTostMessage:@"当前手机号已被注册"];
                     }else{
                         //LDDLog(@"验证码请求失败");
                          [self  showTostMessage:@"请求验证码失败,请重试"];
                     }
                     
                 } failure:^(NSError *error) {
                         LDDLog(@"验证码请求失败");
                 }];
    
//    AFHTTPSessionManager *manager= [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
//    
//    [manager POST:@"http://123.57.141.249:8080/beautalk/appMember/createCode.do" parameters:@{@"MemberId":self.userMessageDic[@"phoneName"]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        //网络请求成功后，调用倒计时方法
//        if ([responseObject[@"result"] isEqualToString:@"success"]) {
//            [self.nextView countdownTime];//调用倒计时方法
//        }else if ([responseObject[@"result"] isEqualToString:@"TelephoneExistError"]){
//            LDDLog(@"手机号已经被注册");
//        }else{
//            LDDLog(@"验证码请求失败");
//        }
//    
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//         LDDLog(@"失败原因:%@",error);
//        
//    }];
    
}

//注册
-(void)registerMethod:(NSString *)code{
    /*
     手机号：LoginName
     密码：Lpassword
     验证码：Code
     手机号：Telephone
     
     */
    [self  getWithURLString:@"appMember/appRegistration.do"
              parameters:@{@"LoginName":_userMessageDic[@"phoneName"],
                           @"Lpassword":_userMessageDic[@"password"],
                           @"Code":code,
                           @"Telephone":_userMessageDic[@"phoneName"]}
                 success:^(id responseObject) {
                     
                     if ([responseObject[@"result"] isEqualToString:@"success"]) {
                        // LDDLog(@"注册成功");
                          [self showTostMessage:@"恭喜您注册成功"];
                     }else if ([responseObject[@"result"] isEqualToString:@"codeError"]){
                         
                         //LDDLog(@"验证码错误");
                         [self showTostMessage:@"验证码错误，请重新输入"];
                         
                     }else{
                         //LDDLog(@"注册失败");
                          [self showTostMessage:@"注册失败"];
                     }
                     

                 } failure:^(NSError *error) {
                     
                     LDDLog(@"失败的原因:%@",error);
                     
                 }];
    
    
    
//    AFHTTPSessionManager *manager= [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
//
//    [manager GET:@"http://123.57.141.249:8080/beautalk/appMember/appRegistration.do" parameters:@{@"LoginName":_userMessageDic[@"phoneName"],
//                              @"Lpassword":_userMessageDic[@"password"],
//                              @"Code":code,
//                              @"Telephone":_userMessageDic[@"phoneName"]}
//        progress:nil
//        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            if ([responseObject[@"result"] isEqualToString:@"success"]) {
//                LDDLog(@"注册成功");
//            }else if ([responseObject[@"result"] isEqualToString:@"codeError"]){
//                
//                LDDLog(@"验证码错误");
//                
//            }else{
//                LDDLog(@"注册失败");
//            }
//             
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//             LDDLog(@"失败的原因:%@",error);
//        
//    }];
    
    
}



-(void)setupConstraints{
    
    [ _nextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
        
    }];
    
}



@end


