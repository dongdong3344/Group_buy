//
//  LDSheetViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/22.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDSheetViewController.h"
#import "LDMineViewController.h"

@interface LDSheetViewController ()


@end

@implementation LDSheetViewController
- (IBAction)cancleAction:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)exitAction:(id)sender {
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ISLOGIN"];
    
   // [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"名称：%@",self.presentedViewController.title);

    }];
    
    
    //创建通知
    NSNotification *notification=[NSNotification notificationWithName:@"reloadData" object:nil ];
 
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];

    


    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
   
    
}

    


    

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"123";
    self.view.backgroundColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
