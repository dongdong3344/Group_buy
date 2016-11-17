//
//  LDBaseViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/17.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDBaseViewController.h"

@interface LDBaseViewController ()

@end

@implementation LDBaseViewController


//get
-(void)getWithURLString:(NSString *)url parameters:(NSDictionary *)param success:(requestSuccessBlock)successBlock failure:(requestFailureBlock)failureBlock{
  
    [SVProgressHUD show];//小圆圈动起来，
    
    
    [LDHTTPTool getWithURLString:url parameters:param success:^(id responseObject) {
        [SVProgressHUD setMinimumDismissTimeInterval:5];//小圆圈动消失
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];//小圆圈消失
        [self showTostMessage:@"网络请求失败，请检查网络状态"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
    
}

//post
-(void)postWithURLString:(NSString *)url parameters:(NSDictionary *)param success:(requestSuccessBlock)successBlock failure:(requestFailureBlock)failureBlock{
    [SVProgressHUD showWithStatus:@"加载中，请稍后"];//小圆圈动起来
  
    [LDHTTPTool  postWithURLString:url parameters:param success:^(id responseObject) {
      
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];//小圆圈显示1秒后消失
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];//小圆圈动消失
        if (failureBlock) {
            failureBlock(error);
        }
        
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)showTostMessage:(NSString *)tost{
    
    [self.view makeToast:tost duration:1.5 position:@"center" ];

    
}
-(void)dismiss{
    
    [SVProgressHUD dismiss];
}
@end
